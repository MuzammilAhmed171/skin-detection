# Implementation Plan: Allopathic Treatment & Homeopathic Information Screens

Implement the exact Allopathic Treatment and Homeopathic Information interfaces shown in the user's image, including top hero cards, search and filter features, disease list cards with disease thumbnails and action buttons, bottom detail checklist cards, bottom disclaimer banners, and rich interactive modal sheets for comprehensive treatment details.

## Proposed User Experience & Design Overview

### 1. **Allopathic Treatment Screen** (`AllopathicPage`)
- **AppBar**: Purple medical theme (`#6C63FF` / `#5A45FF`) with back button and white title "Allopathic Treatment".
- **Hero Card**: "Evidence-Based Care" with shield/cross icon box and subtitle "Trusted allopathic treatments recommended by medical professionals."
- **Interactive Search & Filter**: Search bar with `"Search disease..."`, live search filtering across all conditions, and filter dialog (by category: Parasitic, Fungal, Bacterial, Inflammatory).
- **Disease Cards**:
  1. **1. Scabies**: Scabies thumbnail image, description, and purple pill button **"View Details ->"**.
  2. **2. Fungal Infection (Ringworm)**: Ringworm thumbnail image, description, and purple pill button **"View Details ->"**.
  3. **3. Acne**: Acne thumbnail image, description, and purple pill button **"View Details ->"**.
  4. **4. Eczema**: Eczema thumbnail image, description, and purple pill button **"View Details ->"**.
- **Educational Banner**: Light blue/indigo container with info icon and medical disclaimer text: *"This information is for educational purposes only. Always consult a qualified doctor for proper diagnosis and treatment."*
- **Allopathic Treatment Details Card**: Purple medicine bottle icon `[+]`, title "Allopathic Treatment Details", and purple checkmark list:
  - ✓ Scientifically proven treatments
  - ✓ Doctor recommended medicines
  - ✓ Dose & duration guidance
  - ✓ Side effects & precautions
  - ✓ When to consult a doctor
- **Medical Disclaimer Banner**: Purple banner with white shield icon and medical safety disclaimer.
- **Interactive "View Details" Bottom Sheet / Modal**: Full medical breakdown for each disease including Topical medications, Oral medications, Dosage & instructions, Common side effects, and Precautions.

---

### 2. **Homeopathic Information Screen** (`HomeopathicPage`)
- **AppBar**: Purple medical theme with back button and white title "Homeopathic Information".
- **Hero Card**: "Natural & Holistic Approach" with leaf/botanical icon box and subtitle "Homeopathic remedies may help support the body's natural healing process."
- **Interactive Search & Filter**: Search bar with `"Search disease..."`, live search filtering, and filter dialog.
- **Disease Cards**:
  1. **1. Scabies**: Scabies thumbnail image, homeopathic description, and green pill button **"View Remedies ->"**.
  2. **2. Fungal Infection (Ringworm)**: Ringworm thumbnail image, homeopathic description, and green pill button **"View Remedies ->"**.
  3. **3. Acne**: Acne thumbnail image, homeopathic description, and green pill button **"View Remedies ->"**.
  4. **4. Eczema**: Eczema thumbnail image, homeopathic description, and green pill button **"View Remedies ->"**.
- **Educational Banner**: Light green container with leaf icon and disclaimer text: *"Homeopathic information is not a substitute for professional medical advice. Consult your doctor for severe or persistent conditions."*
- **Homeopathic Information Details Card**: Green medicine bottle icon `[🌿]`, title "Homeopathic Information Details", and green checkmark list:
  - ✓ Commonly used remedies
  - ✓ Natural & holistic approach
  - ✓ Supports body's healing
  - ✓ Safe & gentle options
  - ✓ Lifestyle & diet suggestions
- **Medical Disclaimer Banner**: Purple banner with white shield icon and medical safety disclaimer.
- **Interactive "View Remedies" Bottom Sheet / Modal**: Complete homeopathic remedies breakdown for each disease including Primary remedies (e.g. Sulphur, Silicea, Graphites, Sepia, Thuja), Symptom matching indications, Potency & dosage guide, Dietary and hygiene suggestions, and Natural soothing washes.

---

## Proposed Changes

### Assets & Config
#### [MODIFY] [pubspec.yaml](file:///c:/flutter_project/skin_detection_app/pubspec.yaml)
- Enable `assets/images/` directory in `pubspec.yaml` for disease thumbnails and assets.

#### [NEW] Assets in `assets/images/`
- Generate and place skin disease thumbnail images (`scabies.png`, `ringworm.png`, `acne.png`, `eczema.png`) with graceful fallback to custom-rendered medical visuals.

---

### Treatment Components
#### [MODIFY] [treatment_page.dart](file:///c:/flutter_project/skin_detection_app/lib/treatment_page.dart)
- Completely rebuild `AllopathicPage` and `HomeopathicPage` with pixel-perfect fidelity matching the screenshot.
- Add disease data models for both allopathic and homeopathic clinical details.
- Add live search filtering and filter dialogs.
- Add custom disease cards with thumbnail images and action buttons ("View Details ->" and "View Remedies ->").
- Add bottom "Allopathic Treatment Details" and "Homeopathic Information Details" checklist cards.
- Add bottom full-width Medical Disclaimer banners.
- Add interactive detail modals with clinical depth for all 4 conditions.

#### [MODIFY] [navigation_drawer.dart](file:///c:/flutter_project/skin_detection_app/lib/navigation_drawer.dart)
- Connect drawer items for 'Allopathic (Evidence-Based)' and 'Homeopathic Information' directly to `AllopathicPage()` and `HomeopathicPage()`.

---

## Verification Plan

### Automated Verification
- Run `flutter analyze` via `run_command` to verify zero compile errors, type errors, or lint issues.
- Run `flutter test` to ensure existing test suites pass.

### Manual / Visual Verification
- Verify that both screens match the layout, colors, typography, cards, and structure shown in the user's reference image.
- Verify search functionality filters cards in real-time.
- Verify tapping "View Details ->" opens full allopathic clinical breakdown and "View Remedies ->" opens homeopathic remedies modal.
