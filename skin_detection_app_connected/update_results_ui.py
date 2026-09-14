import sys
import re

file_path = r'c:\Users\N TECH\Desktop\skin disease dataset\skin_detection_app_connected\lib\main.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Update _diseaseDatabase
old_db_pattern = r'final Map<String, Map<String, String>> _diseaseDatabase = \{.*?\};'
new_db = '''final Map<String, Map<String, dynamic>> _diseaseDatabase = {
    'Acne': {
      'allopathic': [
        {'icon': Icons.medication, 'title': 'MEDICINE (ORAL)', 'desc': 'Precision oral treatments for internal conditions.'},
        {'icon': Icons.clean_hands, 'title': 'CREAMS & TOPICALS', 'desc': 'Prescription-grade creams for localized relief.'},
        {'icon': Icons.medical_information, 'title': 'MEDICAL ADVICE', 'desc': 'Professional guidance from specialists.'},
        {'icon': Icons.health_and_safety, 'title': 'TAKE CARE (ROUTINE)', 'desc': 'Daily skincare hygiene and preventive care.'},
      ],
      'homeopathic': [
        {'icon': Icons.spa, 'title': 'HERBAL REMEDIES', 'desc': 'Natural extracts for holistic symptom support.'},
        {'icon': Icons.water_drop, 'title': 'NATURAL OILS', 'desc': 'Therapeutic plant oils for skin nourishment.'},
        {'icon': Icons.restaurant_menu, 'title': 'DIETARY GUIDE', 'desc': 'Holistic nutritional and lifestyle recommendations.'},
        {'icon': Icons.block, 'title': "DO'S & DON'TS", 'desc': 'Essential lifestyle changes and precautions.'},
      ],
      'reasoning': 'Detected typical acne vulgaris patterns.'
    },
    'Chickenpox': {
      'allopathic': [
        {'icon': Icons.medication, 'title': 'MEDICINE (ORAL)', 'desc': 'Antiviral meds and antihistamines for itch.'},
        {'icon': Icons.clean_hands, 'title': 'CREAMS & TOPICALS', 'desc': 'Calamine lotion for soothing the rash.'},
        {'icon': Icons.medical_information, 'title': 'MEDICAL ADVICE', 'desc': 'Consult doctor if fever persists or spots infect.'},
        {'icon': Icons.health_and_safety, 'title': 'TAKE CARE (ROUTINE)', 'desc': 'Keep skin cool. Do not scratch blisters.'},
      ],
      'homeopathic': [
        {'icon': Icons.spa, 'title': 'HERBAL REMEDIES', 'desc': 'Oatmeal baths to relieve severe itching.'},
        {'icon': Icons.water_drop, 'title': 'NATURAL OILS', 'desc': 'Neem or sandalwood paste for cooling effect.'},
        {'icon': Icons.restaurant_menu, 'title': 'DIETARY GUIDE', 'desc': 'Soft, bland foods to prevent mouth sores.'},
        {'icon': Icons.block, 'title': "DO'S & DON'TS", 'desc': 'Do not pop blisters to prevent scarring.'},
      ],
      'reasoning': 'Detected vesicular rashes characteristic of chickenpox.'
    },
    'Eczema': {
      'allopathic': [
        {'icon': Icons.medication, 'title': 'MEDICINE (ORAL)', 'desc': 'Oral corticosteroids for severe flare-ups.'},
        {'icon': Icons.clean_hands, 'title': 'CREAMS & TOPICALS', 'desc': 'Topical steroids and thick emollients.'},
        {'icon': Icons.medical_information, 'title': 'MEDICAL ADVICE', 'desc': 'Allergy testing to identify specific triggers.'},
        {'icon': Icons.health_and_safety, 'title': 'TAKE CARE (ROUTINE)', 'desc': 'Moisturize immediately after lukewarm baths.'},
      ],
      'homeopathic': [
        {'icon': Icons.spa, 'title': 'HERBAL REMEDIES', 'desc': 'Aloe vera and calendula for natural soothing.'},
        {'icon': Icons.water_drop, 'title': 'NATURAL OILS', 'desc': 'Coconut or sunflower seed oil for hydration.'},
        {'icon': Icons.restaurant_menu, 'title': 'DIETARY GUIDE', 'desc': 'Anti-inflammatory diet, avoid common allergens.'},
        {'icon': Icons.block, 'title': "DO'S & DON'TS", 'desc': 'Avoid harsh soaps and synthetic fabrics.'},
      ],
      'reasoning': 'Detected red, itchy, and inflamed skin typical of eczema.'
    },
    'Ringworm': {
      'allopathic': [
        {'icon': Icons.medication, 'title': 'MEDICINE (ORAL)', 'desc': 'Antifungal pills for widespread infections.'},
        {'icon': Icons.clean_hands, 'title': 'CREAMS & TOPICALS', 'desc': 'Antifungal creams (clotrimazole, terbinafine).'},
        {'icon': Icons.medical_information, 'title': 'MEDICAL ADVICE', 'desc': 'Consult if rash doesn\\'t improve in 2 weeks.'},
        {'icon': Icons.health_and_safety, 'title': 'TAKE CARE (ROUTINE)', 'desc': 'Keep affected area clean and dry.'},
      ],
      'homeopathic': [
        {'icon': Icons.spa, 'title': 'HERBAL REMEDIES', 'desc': 'Tea tree oil extracts (diluted) applied topically.'},
        {'icon': Icons.water_drop, 'title': 'NATURAL OILS', 'desc': 'Oregano oil or lemongrass oil as antifungals.'},
        {'icon': Icons.restaurant_menu, 'title': 'DIETARY GUIDE', 'desc': 'Reduce sugar intake to limit fungal growth.'},
        {'icon': Icons.block, 'title': "DO'S & DON'TS", 'desc': 'Do not share towels or personal items.'},
      ],
      'reasoning': 'Detected distinct ring-shaped scaly patches.'
    },
  };'''

content = re.sub(old_db_pattern, new_db, content, flags=re.DOTALL)
content = content.replace("'Dyshidrotic Eczema'", "'Eczema'")
content = content.replace("Dyshidrotic Eczema", "Eczema")

# 2. Update _analyzeImage state setting to avoid using _treatmentSuggestion if it breaks, 
# actually let's just leave _treatmentSuggestion as is, but we will use _diseaseDatabase directly in the UI.

# 3. Dynamic AppBar Title
old_app_bar_title = """            Text(
              'DermaScan AI',
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C2522),
                letterSpacing: -0.3,
              ),
            ),"""
new_app_bar_title = """            Text(
              _predictionResult != null && !_isNotFound ? 'Dual-lens Dermatologist' : 'DermaScan AI',
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C2522),
                letterSpacing: -0.3,
              ),
            ),"""
content = content.replace(old_app_bar_title, new_app_bar_title)

# 4. Replace the Prediction Result Card, Treatment Card, and Disease List Section
# Because the layout of these sections changed drastically, we will replace everything from
# "// Prediction Result Card" to "// Info Card"
start_marker = "// Prediction Result Card"
end_marker = "// Info Card"
start_idx = content.find(start_marker)
end_idx = content.find(end_marker)

new_results_ui = '''// Prediction Result Card
              if (_isNotFound)
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE11D48), Color(0xFFF97316)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE11D48).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.search_off_rounded,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Not Found / Invalid Image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_skinPercentage != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _skinPercentage! < 20.0
                                ? 'Skin Area: ${_skinPercentage!.toStringAsFixed(1)}% (Not Skin)'
                                : 'Confidence: Too Low (${(_confidenceScore != null ? _confidenceScore! * 100 : 0).toStringAsFixed(1)}%)',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      const SizedBox(height: 14),
                      Text(
                        _notFoundMessage ??
                            'The uploaded image is either not human skin or does not match any known condition in our AI model.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.95),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                )
              else if (_predictionResult != null && _confidenceScore != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(color: const Color(0xFFE6DFD5), width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.medical_services_outlined, color: Color(0xFFC78B74), size: 24),
                          const SizedBox(width: 8),
                          Text(
                            'Diagnosis Result',
                            style: GoogleFonts.dmSans(
                              color: const Color(0xFF2C2522),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _predictionResult!,
                        style: GoogleFonts.playfairDisplay(
                          color: const Color(0xFF1C1715),
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(_confidenceScore! * 100).toStringAsFixed(1)}% Confidence',
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFF2C2522).withValues(alpha: 0.7),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              if (_predictionResult != null) const SizedBox(height: 20),

              // Help Tips Card when Not Found
              if (_isNotFound)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.tips_and_updates_outlined, color: Color(0xFFF59E0B), size: 22),
                          SizedBox(width: 8),
                          Text(
                            'How to take a valid photo:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _buildHelpBullet(
                        icon: Icons.wb_sunny_outlined,
                        title: 'Good Lighting',
                        description: 'Ensure natural, clear lighting without heavy shadows or glare.',
                      ),
                      const SizedBox(height: 10),
                      _buildHelpBullet(
                        icon: Icons.center_focus_strong_outlined,
                        title: 'Close & In-Focus',
                        description: 'Center the camera on the affected skin lesion and tap to focus.',
                      ),
                      const SizedBox(height: 10),
                      _buildHelpBullet(
                        icon: Icons.block_outlined,
                        title: 'Skin Lesion Only',
                        description: 'Avoid background objects, animals, furniture, or clothes.',
                      ),
                    ],
                  ),
                ),
              if (_isNotFound) const SizedBox(height: 20),

              // Treatment Card
              if (_predictionResult != null && !_isNotFound && _diseaseDatabase.containsKey(_predictionResult))
                TreatmentToggleCard(diseaseData: _diseaseDatabase[_predictionResult]!),
              if (_predictionResult != null && !_isNotFound) const SizedBox(height: 24),

              // Disease List Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EBE1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xFFE6DFD5), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detectable Diseases',
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1C1715),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDiseaseListItem(Icons.face, 'Acne'),
                    const SizedBox(height: 12),
                    _buildDiseaseListItem(Icons.healing, 'Chickenpox'),
                    const SizedBox(height: 12),
                    _buildDiseaseListItem(Icons.coronavirus_outlined, 'Eczema'),
                    const SizedBox(height: 12),
                    _buildDiseaseListItem(Icons.all_inclusive, 'Ringworm'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              '''

content = content[:start_idx] + new_results_ui + content[end_idx:]

# 5. Add custom widgets and helper methods
new_widgets = '''
  Widget _buildDiseaseListItem(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFFC78B74), size: 18),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 15,
            color: const Color(0xFF2C2522),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class TreatmentToggleCard extends StatefulWidget {
  final Map<String, dynamic> diseaseData;

  const TreatmentToggleCard({super.key, required this.diseaseData});

  @override
  State<TreatmentToggleCard> createState() => _TreatmentToggleCardState();
}

class _TreatmentToggleCardState extends State<TreatmentToggleCard> {
  bool _isAllopathic = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFFE6DFD5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header / Toggle
          Container(
            height: 52,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD6A58E).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isAllopathic = true),
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        'Allopathic treatment',
                        style: GoogleFonts.dmSans(
                          color: _isAllopathic ? Colors.white : Colors.white70,
                          fontWeight: _isAllopathic ? FontWeight.bold : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isAllopathic = !_isAllopathic),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isAllopathic = false),
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Homeopathic',
                            style: GoogleFonts.dmSans(
                              color: !_isAllopathic ? Colors.white : Colors.white70,
                              fontWeight: !_isAllopathic ? FontWeight.bold : FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.eco, size: 16, color: !_isAllopathic ? Colors.white : Colors.white70),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Treatment Grid (2 columns)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column 1 (Items 0, 1)
                Expanded(
                  child: Column(
                    children: [
                      _buildGridItem(widget.diseaseData[_isAllopathic ? 'allopathic' : 'homeopathic'][0]),
                      const SizedBox(height: 20),
                      _buildGridItem(widget.diseaseData[_isAllopathic ? 'allopathic' : 'homeopathic'][1]),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Column 2 (Items 2, 3)
                Expanded(
                  child: Column(
                    children: [
                      _buildGridItem(widget.diseaseData[_isAllopathic ? 'allopathic' : 'homeopathic'][2]),
                      const SizedBox(height: 20),
                      _buildGridItem(widget.diseaseData[_isAllopathic ? 'allopathic' : 'homeopathic'][3]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(item['icon'], color: const Color(0xFFC78B74), size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['title'],
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1C1715),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item['desc'],
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF2C2522).withValues(alpha: 0.7),
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
'''
# add this to the very end of the file, replacing the final brace of _SkinDetectionScreenState
content = content.rstrip()
if content.endswith('}'):
    content = content[:-1] + new_widgets

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('UI updated successfully.')
