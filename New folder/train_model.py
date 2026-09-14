"""
train_model.py – Retrain skin disease classifier with MobileNetV2 fine-tuning.

Usage:
    python train_model.py

Outputs:
    skin_disease_model.keras   – Best Keras model
    skin_disease_model.tflite  – TFLite version (used by Flask server)
    training_history.png       – Loss & accuracy curves

Requirements:
    pip install tensorflow pillow numpy matplotlib scikit-learn
"""

import os, sys, json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

import tensorflow as tf
from tensorflow.keras import layers, models, optimizers, callbacks
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from sklearn.utils.class_weight import compute_class_weight
from pathlib import Path

# ── Config ────────────────────────────────────────────────────────────────────
DATASET_DIR   = Path('dataset')
IMG_SIZE      = (224, 224)
BATCH_SIZE    = 16
EPOCHS_HEAD   = 15   # train only new head first
EPOCHS_FINE   = 20   # then unfreeze top layers
SEED          = 42

CLASS_NAMES = ['Acne', 'Chickenpox', 'Dyshidrotic Eczema', 'Ringworm']
NUM_CLASSES = len(CLASS_NAMES)

print(f"TensorFlow {tf.__version__}")
print(f"Dataset   : {DATASET_DIR}")
print(f"Classes   : {CLASS_NAMES}")
print()

# ── Data generators ───────────────────────────────────────────────────────────
train_datagen = ImageDataGenerator(
    rescale=1.0 / 255,
    rotation_range=25,
    width_shift_range=0.15,
    height_shift_range=0.15,
    shear_range=0.10,
    zoom_range=0.20,
    horizontal_flip=True,
    brightness_range=[0.80, 1.20],
    fill_mode='nearest',
    validation_split=0.20,
)

val_datagen = ImageDataGenerator(
    rescale=1.0 / 255,
    validation_split=0.20,
)

train_gen = train_datagen.flow_from_directory(
    DATASET_DIR,
    target_size=IMG_SIZE,
    batch_size=BATCH_SIZE,
    class_mode='categorical',
    classes=CLASS_NAMES,
    subset='training',
    seed=SEED,
    shuffle=True,
)

val_gen = val_datagen.flow_from_directory(
    DATASET_DIR,
    target_size=IMG_SIZE,
    batch_size=BATCH_SIZE,
    class_mode='categorical',
    classes=CLASS_NAMES,
    subset='validation',
    seed=SEED,
    shuffle=False,
)

print(f"Train samples : {train_gen.samples}")
print(f"Val   samples : {val_gen.samples}")

# ── Class weights (handle imbalanced data) ────────────────────────────────────
y_train = train_gen.classes
class_weights_arr = compute_class_weight(
    class_weight='balanced',
    classes=np.unique(y_train),
    y=y_train,
)
class_weight_dict = dict(enumerate(class_weights_arr))
print(f"Class weights : {class_weight_dict}")
print()

# ── Build model (MobileNetV2 transfer learning) ───────────────────────────────
base_model = MobileNetV2(
    input_shape=(*IMG_SIZE, 3),
    include_top=False,
    weights='imagenet',
)
base_model.trainable = False   # freeze for head training

inputs  = layers.Input(shape=(*IMG_SIZE, 3))
x       = base_model(inputs, training=False)
x       = layers.GlobalAveragePooling2D()(x)
x       = layers.BatchNormalization()(x)
x       = layers.Dense(256, activation='relu')(x)
x       = layers.Dropout(0.4)(x)
x       = layers.Dense(128, activation='relu')(x)
x       = layers.Dropout(0.3)(x)
outputs = layers.Dense(NUM_CLASSES, activation='softmax')(x)

model = models.Model(inputs, outputs)
model.summary(print_fn=lambda x: print(x) if 'Total' in x else None)

# ── Phase 1: Train head only ──────────────────────────────────────────────────
print("=" * 60)
print("Phase 1: Training classification head (base frozen)")
print("=" * 60)

model.compile(
    optimizer=optimizers.Adam(learning_rate=1e-3),
    loss='categorical_crossentropy',
    metrics=['accuracy'],
)

cb_list_phase1 = [
    callbacks.EarlyStopping(monitor='val_accuracy', patience=5,
                            restore_best_weights=True, verbose=1),
    callbacks.ReduceLROnPlateau(monitor='val_loss', factor=0.5,
                                patience=3, min_lr=1e-6, verbose=1),
    callbacks.ModelCheckpoint('skin_disease_model.keras', monitor='val_accuracy',
                              save_best_only=True, verbose=1),
]

hist1 = model.fit(
    train_gen,
    validation_data=val_gen,
    epochs=EPOCHS_HEAD,
    class_weight=class_weight_dict,
    callbacks=cb_list_phase1,
    verbose=1,
)

# ── Phase 2: Fine-tune top layers ─────────────────────────────────────────────
print()
print("=" * 60)
print("Phase 2: Fine-tuning top MobileNetV2 layers")
print("=" * 60)

# Unfreeze top 50 layers of base model
base_model.trainable = True
for layer in base_model.layers[:-50]:
    layer.trainable = False

model.compile(
    optimizer=optimizers.Adam(learning_rate=1e-5),
    loss='categorical_crossentropy',
    metrics=['accuracy'],
)

cb_list_phase2 = [
    callbacks.EarlyStopping(monitor='val_accuracy', patience=7,
                            restore_best_weights=True, verbose=1),
    callbacks.ReduceLROnPlateau(monitor='val_loss', factor=0.3,
                                patience=3, min_lr=1e-8, verbose=1),
    callbacks.ModelCheckpoint('skin_disease_model.keras', monitor='val_accuracy',
                              save_best_only=True, verbose=1),
]

hist2 = model.fit(
    train_gen,
    validation_data=val_gen,
    epochs=EPOCHS_FINE,
    class_weight=class_weight_dict,
    callbacks=cb_list_phase2,
    verbose=1,
)

# ── Load best model & evaluate ────────────────────────────────────────────────
print()
print("Loading best saved model for final evaluation...")
best_model = tf.keras.models.load_model('skin_disease_model.keras')

val_gen.reset()
loss, acc = best_model.evaluate(val_gen, verbose=0)
print(f"Final validation accuracy : {acc * 100:.2f}%")
print(f"Final validation loss     : {loss:.4f}")

# ── Export TFLite ─────────────────────────────────────────────────────────────
print()
print("Converting to TFLite...")
converter = tf.lite.TFLiteConverter.from_keras_model(best_model)
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_model = converter.convert()
with open('skin_disease_model.tflite', 'wb') as f:
    f.write(tflite_model)
tflite_size = os.path.getsize('skin_disease_model.tflite') / 1024 / 1024
print(f"TFLite model saved: skin_disease_model.tflite ({tflite_size:.1f} MB)")

# ── Plot training curves ──────────────────────────────────────────────────────
all_acc  = hist1.history['accuracy']     + hist2.history['accuracy']
all_val  = hist1.history['val_accuracy'] + hist2.history['val_accuracy']
all_loss = hist1.history['loss']         + hist2.history['loss']
all_vloss = hist1.history['val_loss']    + hist2.history['val_loss']

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))
ax1.plot(all_acc,  label='Train Acc')
ax1.plot(all_val,  label='Val Acc')
ax1.axvline(len(hist1.history['accuracy']) - 1, color='red', linestyle='--', label='Fine-tune start')
ax1.set_title('Accuracy'); ax1.legend(); ax1.grid(True)
ax2.plot(all_loss,  label='Train Loss')
ax2.plot(all_vloss, label='Val Loss')
ax2.axvline(len(hist1.history['loss']) - 1, color='red', linestyle='--', label='Fine-tune start')
ax2.set_title('Loss'); ax2.legend(); ax2.grid(True)
plt.suptitle(f'MobileNetV2 Fine-tuning | Val Acc: {acc*100:.2f}%')
plt.tight_layout()
plt.savefig('training_history.png', dpi=120)
print("Training curves saved: training_history.png")

print()
print("DONE! Models saved:")
print("  - skin_disease_model.keras")
print("  - skin_disease_model.tflite")
print("Restart app.py to use the new model.")
