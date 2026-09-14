import 'package:flutter/material.dart';

class SkinCounsellingPage extends StatefulWidget {
  const SkinCounsellingPage({super.key});

  @override
  State<SkinCounsellingPage> createState() => _SkinCounsellingPageState();
}

class _SkinCounsellingPageState extends State<SkinCounsellingPage> {
  // Theme Colors
  static const Color bgColor = Color(0xFFFAF8F5); // Light beige/cream background
  static const Color darkText = Color(0xFF2D2D2D);
  static const Color subtitleText = Color(0xFF6B7280);
  static const Color cardIconBgColor = Color(0xFFF9EBE3); // Light pinkish beige
  static const Color cardIconColor = Color(0xFF8B5A2B); // Brownish

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: darkText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'AI Skin Counselling',
          style: TextStyle(
            color: darkText,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.face_retouching_natural, color: cardIconColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('AI Skin Analysis active ✨')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: Text(
                'Get personalized guidance for healthier, clearer and happier skin.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: subtitleText,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildCounsellingCard(
                    icon: Icons.person_search_outlined,
                    title: 'Skin Symptoms',
                    description: 'Select your skin symptoms like itching, redness, acne, dryness, etc. and get AI-based suggestions.',
                    onTap: () => _showActionDialog(
                      title: 'Skin Symptoms',
                      details: 'Select your symptoms like itching, burning, redness, or dryness so the AI can provide personalized suggestions.',
                      icon: Icons.person_search_outlined,
                      actionButtons: [
                        _buildDialogButton(
                          icon: Icons.add_circle_outline,
                          label: 'Log New Symptom',
                          onTap: () => Navigator.pop(context),
                        ),
                        const SizedBox(height: 8),
                        _buildDialogButton(
                          icon: Icons.analytics_outlined,
                          label: 'Analyze Symptoms',
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  _buildCounsellingCard(
                    icon: Icons.assignment_ind_outlined,
                    title: 'Skin History',
                    description: 'Tell us about your past skin issues, allergies and current skincare or medicines you are using.',
                    onTap: () => _showActionDialog(
                      title: 'Skin History',
                      details: 'Provide basic information about your previous skin problems, allergies, and current skincare routine or medications.',
                      icon: Icons.assignment_ind_outlined,
                      actionButtons: [
                        _buildDialogButton(
                          icon: Icons.history,
                          label: 'View History',
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  _buildCounsellingCard(
                    icon: Icons.wb_sunny_outlined,
                    title: 'Trigger Check',
                    description: 'Find possible triggers like sun exposure, cosmetics, stress, diet, weather or other factors affecting your skin.',
                    onTap: () => _showActionDialog(
                      title: 'Trigger Check',
                      details: 'Let AI help you identify possible triggers such as sun exposure, cosmetics, stress, or weather changes.',
                      icon: Icons.wb_sunny_outlined,
                      actionButtons: [
                        _buildDialogButton(
                          icon: Icons.search,
                          label: 'Identify Triggers',
                          onTap: () => Navigator.pop(context),
                        ),
                        const SizedBox(height: 8),
                        _buildDialogButton(
                          icon: Icons.warning_amber_rounded,
                          label: 'My Known Triggers',
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  _buildCounsellingCard(
                    icon: Icons.fact_check_outlined,
                    title: "Skin Do's & Don'ts",
                    description: "Get simple do's and don'ts based on your skin condition to avoid further issues.",
                    onTap: () => _showActionDialog(
                      title: "Skin Do's & Don'ts",
                      details: "Learn what to do and what to avoid according to your specific skin problems.",
                      icon: Icons.fact_check_outlined,
                      actionButtons: [
                        _buildDialogButton(
                          icon: Icons.menu_book_outlined,
                          label: 'Read Guidelines',
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  _buildCounsellingCard(
                    icon: Icons.edit_calendar_outlined,
                    title: 'Follow-Up Reminder',
                    description: 'Set reminders for your skincare or treatment follow-up and track your progress.',
                    onTap: () => _showActionDialog(
                      title: 'Follow-Up Reminder',
                      details: 'Set reminders for your skincare routines or treatment follow-ups and keep track of your progress.',
                      icon: Icons.edit_calendar_outlined,
                      actionButtons: [
                        _buildDialogButton(
                          icon: Icons.alarm_add,
                          label: 'Set New Reminder',
                          onTap: () => Navigator.pop(context),
                        ),
                        const SizedBox(height: 8),
                        _buildDialogButton(
                          icon: Icons.list_alt,
                          label: 'View All Reminders',
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounsellingCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardIconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: cardIconColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: subtitleText,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showActionDialog({
    required String title,
    required String details,
    required IconData icon,
    required List<Widget> actionButtons,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 24.0,
            bottom: MediaQuery.of(context).padding.bottom + 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: cardIconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: cardIconColor, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                details,
                style: const TextStyle(
                  fontSize: 15,
                  color: subtitleText,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              ...actionButtons,
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: subtitleText,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDialogButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: cardIconBgColor,
          foregroundColor: cardIconColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
