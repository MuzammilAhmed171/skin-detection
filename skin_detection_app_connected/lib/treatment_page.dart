import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFD4A373);
const Color darkText = Color(0xFF20233A);
const Color lightBackground = Color(0xFFFCF9F2);
const Color greenColor = Color(0xFF2E9D57);

class TreatmentPage extends StatelessWidget {
  const TreatmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Treatment Information',
          style: TextStyle(
            color: darkText,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // HEADER
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFD4A373),
                    Color(0xFFE8C39E),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Icon(
                    Icons.medical_information_outlined,
                    color: Colors.white,
                    size: 45,
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Skin Treatment Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Learn about treatment options for your skin condition.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // TITLE
            // =========================
            const Text(
              'Choose Treatment Type',
              style: TextStyle(
                color: darkText,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            // =========================
            // ALLOPATHIC
            // =========================
            _treatmentCard(
              context: context,
              title: 'Allopathic Treatment',
              description:
                  'Medical treatment information for Acne, Dyshidrotic Eczema, Chickenpox and Ringworm.',
              icon: Icons.medical_services_outlined,
              iconColor: primaryColor,
              backgroundColor: const Color(0xFFF1E3D3),
              page: const AllopathicPage(),
            ),

            const SizedBox(height: 18),

            // =========================
            // HOMEOPATHIC
            // =========================
            _treatmentCard(
              context: context,
              title: 'Homeopathic Information',
              description:
                  'Complementary information for Acne, Dyshidrotic Eczema, Chickenpox and Ringworm.',
              icon: Icons.eco_outlined,
              iconColor: greenColor,
              backgroundColor: const Color(0xFFFDF5E6),
              page: const HomeopathicPage(),
            ),

            const SizedBox(height: 24),

            // =========================
            // WARNING
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7E5),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 28,
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'This information is for educational purposes. '
                      'Prescription treatment should be decided by a qualified doctor.',
                      style: TextStyle(
                        color: Color(0xFF6F5B35),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // TREATMENT CARD
  // =========================

  Widget _treatmentCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required Widget page,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          children: [

            // ICON
            Container(
              width: 72,
              height: 72,

              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Icon(
                icon,
                color: iconColor,
                size: 38,
              ),
            ),

            const SizedBox(width: 16),

            // TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      color: darkText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF6E7183),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 5),

            Icon(
              Icons.arrow_forward_ios,
              color: iconColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}


// ==========================================================
// ALLOPATHIC PAGE
// ==========================================================

class AllopathicPage extends StatelessWidget {
  const AllopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Allopathic Treatment',
          style: TextStyle(
            color: darkText,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [

          _introCard(
            'Allopathic Treatment',
            'Select a disease to view medicines and treatment suggestions.',
            primaryColor,
            Icons.medical_services_outlined,
          ),

          const SizedBox(height: 20),

          _diseaseCard(
            context,
            'Acne',
            'Pimples, blackheads and oily skin',
            Icons.face_retouching_natural,
            primaryColor,
            const AcneAllopathicPage(),
          ),

          _diseaseCard(
            context,
            'Dyshidrotic Eczema',
            'Small itchy blisters on the hands or feet',
            Icons.back_hand_outlined,
            Colors.blue,
            const DyshidroticEczemaAllopathicPage(),
          ),

          _diseaseCard(
            context,
            'Chickenpox',
            'Itchy fluid-filled spots and rash',
            Icons.coronavirus_outlined,
            greenColor,
            const ChickenpoxAllopathicPage(),
          ),

          _diseaseCard(
            context,
            'Ringworm',
            'Itchy, scaly or ring-shaped rash',
            Icons.circle_outlined,
            Colors.orange,
            const RingwormAllopathicPage(),
          ),
        ],
      ),
    );
  }
}


// ==========================================================
// HOMEOPATHIC PAGE
// ==========================================================

class HomeopathicPage extends StatelessWidget {
  const HomeopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Homeopathic Information',
          style: TextStyle(
            color: darkText,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [

          // NOTICE
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7E5),
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Icon(
                  Icons.info_outline,
                  color: Colors.orange,
                  size: 26,
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Text(
                    'Homeopathic information is provided for educational '
                    'purposes and should not replace proven medical treatment.',
                    style: TextStyle(
                      color: Color(0xFF6F5B35),
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          _introCard(
            'Homeopathic Information',
            'Select a disease to view complementary information and suggestions.',
            greenColor,
            Icons.eco_outlined,
          ),

          const SizedBox(height: 20),

          _diseaseCard(
            context,
            'Acne',
            'Complementary information for acne',
            Icons.face_retouching_natural,
            primaryColor,
            const AcneHomeopathicPage(),
          ),

          _diseaseCard(
            context,
            'Dyshidrotic Eczema',
            'Complementary information for dyshidrotic eczema',
            Icons.back_hand_outlined,
            Colors.blue,
            const DyshidroticEczemaHomeopathicPage(),
          ),

          _diseaseCard(
            context,
            'Chickenpox',
            'Complementary information for chickenpox',
            Icons.coronavirus_outlined,
            greenColor,
            const ChickenpoxHomeopathicPage(),
          ),

          _diseaseCard(
            context,
            'Ringworm',
            'Complementary information for ringworm',
            Icons.circle_outlined,
            Colors.orange,
            const RingwormHomeopathicPage(),
          ),
        ],
      ),
    );
  }
}


// ==========================================================
// COMMON INTRO CARD
// ==========================================================

Widget _introCard(
  String title,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(22),
    ),

    child: Row(
      children: [

        Icon(
          icon,
          color: color,
          size: 40,
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                description,
                style: const TextStyle(
                  color: Color(0xFF6E7183),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


// ==========================================================
// DISEASE CARD
// ==========================================================

Widget _diseaseCard(
  BuildContext context,
  String title,
  String description,
  IconData icon,
  Color color,
  Widget page,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),

    child: InkWell(
      borderRadius: BorderRadius.circular(22),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [

            Container(
              width: 62,
              height: 62,

              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(18),
              ),

              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      color: darkText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF77798A),
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 18,
            ),
          ],
        ),
      ),
    ),
  );
}


// ==========================================================
// ALLOPATHIC DISEASE DETAIL PAGES
// ==========================================================

class AcneAllopathicPage extends StatelessWidget {
  const AcneAllopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _detailPage(
      context,
      'Acne',
      Icons.face_retouching_natural,
      primaryColor,
      'Acne is a common skin condition that causes pimples, blackheads and whiteheads.',
      [
        'Benzoyl peroxide',
        'Adapalene',
        'Salicylic acid',
        'Topical antibiotics may be prescribed in selected cases',
      ],
      [
        'Wash the face gently twice daily.',
        'Avoid squeezing or picking pimples.',
        'Use non-comedogenic skin-care products.',
        'Use sunscreen suitable for acne-prone skin.',
        'See a dermatologist if acne is severe or persistent.',
      ],
    );
  }
}


class DyshidroticEczemaAllopathicPage extends StatelessWidget {
  const DyshidroticEczemaAllopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _detailPage(
      context,
      'Dyshidrotic Eczema',
      Icons.back_hand_outlined,
      Colors.blue,
      'Dyshidrotic eczema causes small, itchy blisters, usually on the hands and feet.',
      [
        'Moisturizers / emollients',
        'Topical corticosteroids when prescribed',
        'Anti-itch medicines may be recommended',
        'Other anti-inflammatory treatments may be prescribed',
      ],
      [
        'Keep the hands and feet moisturized regularly.',
        'Avoid harsh soaps, detergents and fragrances.',
        'Use cool compresses to soothe itching.',
        'Wear protective gloves when handling irritants.',
        'See a dermatologist if blisters are severe or persistent.',
      ],
    );
  }
}


class ChickenpoxAllopathicPage extends StatelessWidget {
  const ChickenpoxAllopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _detailPage(
      context,
      'Chickenpox',
      Icons.coronavirus_outlined,
      greenColor,
      'Chickenpox is a contagious infection that causes an itchy, blister-like rash and fever.',
      [
        'Paracetamol may help reduce fever when appropriate',
        'Anti-itch medicines may help symptoms',
        'Antiviral medicine may be prescribed for selected patients',
        'Avoid aspirin in children with suspected chickenpox',
      ],
      [
        'Avoid scratching the spots.',
        'Keep fingernails short and clean.',
        'Stay away from people at high risk until a doctor advises it is safe.',
        'Keep the skin clean and wear loose clothing.',
        'Consult a doctor if symptoms are severe or worsening.',
      ],
    );
  }
}


class RingwormAllopathicPage extends StatelessWidget {
  const RingwormAllopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _detailPage(
      context,
      'Ringworm',
      Icons.circle_outlined,
      Colors.orange,
      'Ringworm is a fungal skin infection that can cause an itchy, scaly or ring-shaped rash.',
      [
        'Clotrimazole',
        'Terbinafine',
        'Other topical antifungal medicines',
        'Oral antifungal medicines may be prescribed for selected infections',
      ],
      [
        'Keep the affected area clean and dry.',
        'Change sweaty clothes quickly.',
        'Wear breathable clothing.',
        'Do not share towels, clothing or personal items.',
        'Consult a doctor if the rash spreads or persists.',
      ],
    );
  }
}


// ==========================================================
// HOMEOPATHIC DISEASE DETAIL PAGES
// ==========================================================

class AcneHomeopathicPage extends StatelessWidget {
  const AcneHomeopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _homeopathicDetail(
      context,
      'Acne',
      primaryColor,
      Icons.face_retouching_natural,
      [
        'Sulphur is commonly discussed in homeopathic practice.',
        'Hepar sulphuris is sometimes discussed for skin complaints.',
        'Silicea is sometimes discussed for persistent skin complaints.',
      ],
      [
        'Keep the skin clean.',
        'Avoid picking pimples.',
        'Use gentle skin-care products.',
        'Do not replace effective acne treatment with homeopathy alone.',
        'Consult a qualified healthcare professional.',
      ],
    );
  }
}


class DyshidroticEczemaHomeopathicPage extends StatelessWidget {
  const DyshidroticEczemaHomeopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _homeopathicDetail(
      context,
      'Dyshidrotic Eczema',
      Colors.blue,
      Icons.back_hand_outlined,
      [
        'Graphites is commonly discussed in homeopathic practice.',
        'Sulphur is sometimes discussed for itchy skin complaints.',
        'Petroleum is sometimes discussed for cracked skin complaints.',
      ],
      [
        'Keep the hands and feet moisturized.',
        'Avoid known triggers and harsh products.',
        'Use gentle skin-care products.',
        'Do not stop prescribed treatment without medical advice.',
        'Consult a healthcare professional.',
      ],
    );
  }
}


class ChickenpoxHomeopathicPage extends StatelessWidget {
  const ChickenpoxHomeopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _homeopathicDetail(
      context,
      'Chickenpox',
      greenColor,
      Icons.coronavirus_outlined,
      [
        'Rhus toxicodendron is sometimes discussed for itchy rashes.',
        'Antimonium tartaricum is sometimes discussed in homeopathic practice.',
        'Apis mellifica is sometimes discussed for burning or stinging sensations.',
      ],
      [
        'Avoid scratching the rash.',
        'Keep the skin clean and wear loose clothing.',
        'Do not replace medical care with homeopathy alone.',
        'Avoid close contact with people at high risk.',
        'Consult a qualified healthcare professional.',
      ],
    );
  }
}


class RingwormHomeopathicPage extends StatelessWidget {
  const RingwormHomeopathicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _homeopathicDetail(
      context,
      'Ringworm',
      Colors.orange,
      Icons.circle_outlined,
      [
        'Tellurium is sometimes discussed for ring-like skin complaints.',
        'Sulphur is commonly discussed in homeopathic practice.',
        'Graphites is sometimes discussed for chronic skin symptoms.',
      ],
      [
        'Keep the affected area clean and dry.',
        'Avoid sharing towels and clothes.',
        'Use proven antifungal treatment when infection is diagnosed.',
        'Do not rely on homeopathy alone for a confirmed fungal infection.',
        'Consult a dermatologist if symptoms persist.',
      ],
    );
  }
}


// ==========================================================
// DETAIL PAGE
// ==========================================================

Widget _detailPage(
  BuildContext context,
  String title,
  IconData icon,
  Color color,
  String description,
  List<String> medicines,
  List<String> suggestions,
) {
  return Scaffold(
    backgroundColor: lightBackground,

    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,

      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: primaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: darkText,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    body: ListView(
      padding: const EdgeInsets.all(18),
      children: [

        // HEADER
        Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Icon(
                icon,
                color: Colors.white,
                size: 45,
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        _section(
          'Medicines',
          Icons.medication_outlined,
          color,
          medicines,
        ),

        _section(
          'Treatment Suggestions',
          Icons.lightbulb_outline,
          greenColor,
          suggestions,
        ),

        _warning(),
      ],
    ),
  );
}


// ==========================================================
// HOMEOPATHIC DETAIL
// ==========================================================

Widget _homeopathicDetail(
  BuildContext context,
  String title,
  Color color,
  IconData icon,
  List<String> remedies,
  List<String> suggestions,
) {
  return Scaffold(
    backgroundColor: lightBackground,

    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,

      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: primaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: darkText,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    body: ListView(
      padding: const EdgeInsets.all(18),
      children: [

        Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
          ),

          child: Row(
            children: [

              Icon(
                icon,
                color: Colors.white,
                size: 45,
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Text(
                  '$title - Homeopathic Information',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        _section(
          'Commonly Discussed Remedies',
          Icons.eco_outlined,
          color,
          remedies,
        ),

        _section(
          'Suggestions',
          Icons.lightbulb_outline,
          greenColor,
          suggestions,
        ),

        Container(
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: const Color(0xFFFFEEF0),
            borderRadius: BorderRadius.circular(22),
          ),

          child: const Text(
            'Important: Homeopathic information is provided for '
            'educational purposes. It should not replace evidence-based '
            'medical care or prescribed treatment.',
            style: TextStyle(
              color: Color(0xFF9C3E48),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}


// ==========================================================
// SECTION
// ==========================================================

Widget _section(
  String title,
  IconData icon,
  Color color,
  List<String> items,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(18),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            Icon(
              icon,
              color: color,
              size: 23,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 9),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  '•',
                  style: TextStyle(
                    color: color,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Color(0xFF555867),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


// ==========================================================
// WARNING
// ==========================================================

Widget _warning() {
  return Container(
    padding: const EdgeInsets.all(18),

    decoration: BoxDecoration(
      color: const Color(0xFFFFEEF0),
      borderRadius: BorderRadius.circular(22),
    ),

    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 27,
        ),

        SizedBox(width: 10),

        Expanded(
          child: Text(
            'For severe, spreading, painful or persistent symptoms, '
            'please consult a qualified dermatologist or doctor.',
            style: TextStyle(
              color: Color(0xFF9C3E48),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}