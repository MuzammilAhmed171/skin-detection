import 'package:flutter/material.dart';

class AITreatmentPlanScreen extends StatefulWidget {
  const AITreatmentPlanScreen({super.key});

  @override
  State<AITreatmentPlanScreen> createState() =>
      _AITreatmentPlanScreenState();
}

class _AITreatmentPlanScreenState extends State<AITreatmentPlanScreen> {
  int _selectedTab = 0;

  final List<bool> _morningDone = [false, false, false, false];

  final TextEditingController _chatController = TextEditingController();

  final List<Map<String, String>> _messages = [
    {
      'type': 'ai',
      'text':
          'Hello! 👋 I am your Skin AI Assistant. How can I help you with your skin today?',
    },
  ];

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _chatController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'type': 'user',
        'text': text,
      });

      _chatController.clear();

      _messages.add({
        'type': 'ai',
        'text': _getAIResponse(text),
      });
    });
  }

  String _getAIResponse(String question) {
    final q = question.toLowerCase();

    if (q.contains('acne') || q.contains('pimple')) {
      return 'For acne, keep your skin clean with a gentle cleanser, avoid squeezing pimples, use a non-comedogenic moisturizer and sunscreen. If acne becomes severe, painful, or leaves scars, consult a dermatologist.';
    }

    if (q.contains('eczema') || q.contains('itch')) {
      return 'Eczema can cause dryness, redness and itching. Use a gentle fragrance-free moisturizer regularly, avoid known irritants and do not scratch the affected skin. Persistent or severe symptoms should be reviewed by a dermatologist.';
    }

    if (q.contains('fungal') || q.contains('ringworm')) {
      return 'Fungal infections can cause itchy, red or scaly patches. Keep the affected area clean and dry, avoid sharing towels or clothing, and follow an appropriate antifungal treatment recommended by a healthcare professional.';
    }

    if (q.contains('scabies')) {
      return 'Scabies commonly causes intense itching, especially at night, with small bumps or a rash. It requires proper medical treatment and close-contact precautions. A dermatologist should confirm the diagnosis and guide treatment.';
    }

    if (q.contains('red') || q.contains('redness')) {
      return 'If your skin is more red today, avoid harsh products and new skincare products. Use a gentle cleanser, moisturizer and sunscreen. If redness is severe, painful, rapidly spreading, or associated with swelling or breathing difficulty, seek medical care promptly.';
    }

    if (q.contains('treatment')) {
      return 'Your treatment plan should be based on your latest skin analysis. Follow the recommended routine consistently and avoid changing multiple products at the same time.';
    }

    return 'I can help you understand Acne, Eczema, Fungal Infection and Scabies, including symptoms, causes, care and when you should see a doctor. Please tell me what is bothering you about your skin.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF17172A),
        title: const Text(
          'AI Treatment Plan',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new notifications'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTopTabs(),
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                _buildTreatmentPlan(),
                _buildAskSkinAI(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: Row(
        children: [
          _tabButton(
            title: 'AI Plan',
            icon: Icons.auto_awesome_rounded,
            index: 0,
          ),
          _tabButton(
            title: 'Ask Skin AI',
            icon: Icons.smart_toy_rounded,
            index: 1,
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required String title,
    required IconData icon,
    required int index,
  }) {
    final selected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFF1E3D3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 21,
                color: selected
                    ? const Color(0xFFD4A373)
                    : const Color(0xFF77778A),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight:
                      selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected
                      ? const Color(0xFFD4A373)
                      : const Color(0xFF555568),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // AI TREATMENT PLAN
  // ============================================================

  Widget _buildTreatmentPlan() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAIHeader(),
          const SizedBox(height: 16),
          _buildLatestAnalysis(),
          const SizedBox(height: 18),
          const Text(
            'Your Personalized Treatment Plan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF18182A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Based on your latest skin analysis',
            style: TextStyle(
              color: Color(0xFF77778A),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          _buildMorningRoutine(),
          const SizedBox(height: 18),
          _buildDoctorReviewButton(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildAIHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFD4A373),
            Color(0xFFE8C39E),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4A373).withOpacity(0.20),
            blurRadius: 15,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 78,
            width: 78,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              size: 48,
              color: Color(0xFFD4A373),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi! I\'m your',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'AI Skin Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'I\'m here to guide you through your skin care journey.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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

  Widget _buildLatestAnalysis() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE7E5EF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Latest Skin Analysis',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _showLatestAnalysisDialog();
                },
                child: const Text('View Details'),
              ),
            ],
          ),
          const Text(
            'Latest analysis result',
            style: TextStyle(
              color: Color(0xFF858595),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _diseasePlaceholder(
                disease: 'Acne',
                icon: Icons.face_retouching_natural_rounded,
                color: const Color(0xFFFF9B82),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Condition',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF858595),
                      ),
                    ),
                    Text(
                      'Acne',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Severity',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF858595),
                      ),
                    ),
                    Text(
                      'Moderate',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFFF7043),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF2FA44F),
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '91%',
                    style: TextStyle(
                      color: Color(0xFF23933E),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _diseasePlaceholder({
    required String disease,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      height: 76,
      width: 76,
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 40,
        color: color,
      ),
    );
  }

  Widget _buildMorningRoutine() {
    final routine = [
      {
        'title': 'Cleanser',
        'subtitle': 'Gentle facial cleanser',
        'icon': Icons.local_drink_outlined,
      },
      {
        'title': 'Treatment',
        'subtitle': 'Recommended skin treatment',
        'icon': Icons.medication_outlined,
      },
      {
        'title': 'Moisturizer',
        'subtitle': 'Lightweight moisturizer',
        'icon': Icons.water_drop_outlined,
      },
      {
        'title': 'Sunscreen',
        'subtitle': 'Broad spectrum SPF 30+',
        'icon': Icons.wb_sunny_outlined,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE6E4EE),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color(0xFFF8F7FF),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(17),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.wb_sunny_outlined,
                  color: Color(0xFFFF9800),
                  size: 24,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Morning Routine',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Your recommended morning care',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF77778A),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(
            routine.length,
            (index) {
              final item = routine[index];

              return _routineItem(
                index: index,
                title: item['title'] as String,
                subtitle: item['subtitle'] as String,
                icon: item['icon'] as IconData,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _routineItem({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _morningDone[index] = !_morningDone[index];
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        child: Row(
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFF1E3D3),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFD4A373),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      decoration: _morningDone[index]
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF77778A),
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: _morningDone[index],
              activeColor: const Color(0xFFD4A373),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onChanged: (value) {
                setState(() {
                  _morningDone[index] = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorReviewButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton.icon(
        onPressed: () {
          _showDoctorReviewDialog();
        },
        icon: const Icon(
          Icons.person_add_alt_1_rounded,
        ),
        label: const Text(
          'Request Doctor Review',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFD4A373),
          side: const BorderSide(
            color: Color(0xFFD4A373),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ASK SKIN AI
  // ============================================================

  Widget _buildAskSkinAI() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
            children: [
              const Text(
                'Hello! 👋',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'How can I help you with your skin today?',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  color: Color(0xFF555568),
                ),
              ),
              const SizedBox(height: 18),
              _quickQuestion('Why do I have acne?'),
              _quickQuestion('How should I care for eczema?'),
              _quickQuestion('Could this be a fungal infection?'),
              _quickQuestion('What are common scabies symptoms?'),
              _quickQuestion('My skin is more red today'),
              const SizedBox(height: 18),
              ..._messages.map(
                (message) {
                  return _chatBubble(
                    isUser: message['type'] == 'user',
                    text: message['text'] ?? '',
                  );
                },
              ),
            ],
          ),
        ),
        _buildChatInput(),
      ],
    );
  }

  Widget _quickQuestion(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            _chatController.text = text;
            _sendMessage();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFE0DEE9),
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF3D3D50),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chatBubble({
    required bool isUser,
    required String text,
  }) {
    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 330,
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUser
              ? const Color(0xFFD4A373)
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(17),
            topRight: const Radius.circular(17),
            bottomLeft: Radius.circular(
              isUser ? 17 : 4,
            ),
            bottomRight: Radius.circular(
              isUser ? 4 : 17,
            ),
          ),
          border: isUser
              ? null
              : Border.all(
                  color: const Color(0xFFE5E3ED),
                ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser
                ? Colors.white
                : const Color(0xFF313143),
            fontSize: 13,
            height: 1.45,
          ),
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _chatController,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF9999A8),
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF7F6FB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(27),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 13,
                  ),
                  suffixIcon: const Icon(
                    Icons.mic_none_rounded,
                    color: Color(0xFF77778A),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF6B5CF0),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DIALOGS
  // ============================================================

  void _showLatestAnalysisDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Latest Skin Analysis'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detected Condition',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Acne',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14),
              Text(
                'Severity',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Moderate',
                style: TextStyle(
                  color: Color(0xFFFF7043),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14),
              Text(
                'AI Confidence',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '91%',
                style: TextStyle(
                  color: Color(0xFF23933E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showDoctorReviewDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.person_add_alt_1_rounded,
                color: Color(0xFFD4A373),
              ),
              SizedBox(width: 10),
              Text('Doctor Review'),
            ],
          ),
          content: const Text(
            'Your skin analysis and treatment information can be shared with a dermatologist for professional review.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Doctor review request submitted.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
                foregroundColor: Colors.white,
              ),
              child: const Text('Request Review'),
            ),
          ],
        );
      },
    );
  }
}

// ================================================================
// DISEASE DETAILS SCREEN
// ================================================================

class DiseaseDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DiseaseDetailsScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = data['color'] as Color;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF17172A),
        title: Text(
          data['name'],
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(0.70),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    data['icon'] as IconData,
                    size: 42,
                    color: color,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _infoSection(
            title: 'Overview',
            icon: Icons.info_outline_rounded,
            color: color,
            child: Text(
              data['description'],
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF4D4D5D),
              ),
            ),
          ),

          _infoSection(
            title: 'Common Symptoms',
            icon: Icons.medical_information_outlined,
            color: color,
            child: _bulletList(
              data['symptoms'] as List<String>,
            ),
          ),

          _infoSection(
            title: 'Causes & Triggers',
            icon: Icons.search_rounded,
            color: color,
            child: _bulletList(
              data['causes'] as List<String>,
            ),
          ),

          _infoSection(
            title: 'Treatment & Care',
            icon: Icons.health_and_safety_outlined,
            color: color,
            child: _bulletList(
              data['care'] as List<String>,
            ),
          ),

          _infoSection(
            title: 'When to See a Doctor',
            icon: Icons.local_hospital_outlined,
            color: const Color(0xFFE05A47),
            child: Text(
              data['doctor'],
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF4D4D5D),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 25),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7E6),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFFF0DDA8),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFD58A00),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Educational information only. A dermatologist should confirm diagnosis and prescribe treatment when required.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.45,
                      color: Color(0xFF6C592B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSection({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE5E3ED),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 19,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          child,
        ],
      ),
    );
  }

  Widget _bulletList(List<String> items) {
    return Column(
      children: items.map(
        (item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 18,
                  color: Color(0xFF35A853),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Color(0xFF4D4D5D),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
