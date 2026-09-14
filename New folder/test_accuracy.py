import requests
import glob
import os

BASE = 'http://127.0.0.1:5000'
classes = ['Acne', 'Chickenpox', 'Dyshidrotic Eczema', 'Ringworm']

total = 0
correct = 0

for cls in classes:
    imgs = (glob.glob(f'dataset/{cls}/*.jpg') + 
            glob.glob(f'dataset/{cls}/*.png') + 
            glob.glob(f'dataset/{cls}/*.jpeg'))[:20]  # test up to 20 per class
    
    cls_correct = 0
    cls_total = 0
    
    for img_path in imgs:
        with open(img_path, 'rb') as f:
            r = requests.post(f'{BASE}/predict', files={'image': f})
        d = r.json()
        pred = d.get('prediction')
        cls_total += 1
        total += 1
        if pred == cls:
            cls_correct += 1
            correct += 1
    
    acc = (cls_correct / cls_total * 100) if cls_total > 0 else 0
    print(f'{cls}: {cls_correct}/{cls_total} = {acc:.1f}%')

print()
overall = (correct / total * 100) if total > 0 else 0
print(f'Overall: {correct}/{total} = {overall:.1f}%')
