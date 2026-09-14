import requests
import glob

BASE = 'http://127.0.0.1:5000'

# Health check
r = requests.get(f'{BASE}/health')
print('Health:', r.json())
print()

# Test each class
classes = ['Acne', 'Chickenpox', 'Dyshidrotic Eczema', 'Ringworm']
for cls in classes:
    imgs = glob.glob(f'dataset/{cls}/*.jpg')[:1] + glob.glob(f'dataset/{cls}/*.png')[:1]
    if imgs:
        with open(imgs[0], 'rb') as f:
            r = requests.post(f'{BASE}/predict', files={'image': f})
        d = r.json()
        pred = d.get('prediction')
        conf = d.get('confidence')
        skin = d.get('skin_percentage')
        valid = d.get('is_valid_disease')
        correct = '[OK]' if pred == cls else '[WRONG]'
        print(f'{correct} [{cls}] -> Pred: {pred} | Conf: {conf}% | Skin: {skin}% | Valid: {valid}')
    else:
        print(f'[SKIP] No images for {cls}')
