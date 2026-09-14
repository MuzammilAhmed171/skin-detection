import 'package:flutter/material.dart';
import 'ai_treatment_plan_screen.dart';
import 'my_profile_page.dart';
import 'settings_page.dart';
import 'contact_us.dart';
import 'skin_counselling_page.dart';
import 'treatment_page.dart';
import 'appointments_screen.dart';

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({super.key});

  @override
  State<CustomNavigationDrawer> createState() =>
      _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState
    extends State<CustomNavigationDrawer> {
  String selectedLanguage = 'English';

  final Color primaryColor = const Color(0xFFD4A373);
  final Color secondaryColor = const Color(0xFFE8C39E);

  // =====================================================
  // LANGUAGE DIALOG
  // =====================================================

  void showLanguageDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Select Language',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: primaryColor,
                ),
                title: const Text('English'),
                trailing: selectedLanguage == 'English'
                    ? Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    selectedLanguage = 'English';
                  });

                  Navigator.pop(dialogContext);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: primaryColor,
                ),
                title: const Text('Urdu'),
                trailing: selectedLanguage == 'Urdu'
                    ? Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    selectedLanguage = 'Urdu';
                  });

                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // =====================================================
  // LOGOUT DIALOG
  // =====================================================

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                // Close drawer
                Navigator.pop(context);

                // Return to first screen
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // APPOINTMENTS
  // =====================================================

  void openAppointments() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentsScreen(),
      ),
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // =================================================
            // HEADER
            // =================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFD4A373),
                    Color(0xFFE8C39E),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // PROFILE ICON
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xFFD4A373),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Care Your Skin',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Dual-Lens Dermatologist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // MENU
            // =================================================

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                children: [
                  // =================================================
                  // MY PROFILE
                  // =================================================

                  DrawerMenuItem(
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    color: primaryColor,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyProfilePage(),
                        ),
                      );
                    },
                  ),

                  // =================================================
                  // APPOINTMENTS
                  // =================================================

                  DrawerMenuItem(
                    icon: Icons.calendar_month_outlined,
                    title: 'Appointments',
                    color: primaryColor,
                    onTap: openAppointments,
                  ),

                  // =================================================
                  // TREATMENT
                  // =================================================

                  ExpansionTile(
                    leading: Icon(
                      Icons.medical_services_outlined,
                      color: primaryColor,
                    ),
                    title: const Text(
                      'Treatment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    childrenPadding: const EdgeInsets.only(
                      left: 25,
                    ),
                    children: [
                      // AI TREATMENT PLAN
                      ListTile(
                        leading: Icon(
                          Icons.medical_information_outlined,
                          color: primaryColor,
                        ),
                        title: const Text(
                          'AI Treatment Plan',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                   const AITreatmentPlanScreen(),
                            ),
                          );
                        },
                      ),

                      // TREATMENT INFORMATION
                      ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: primaryColor,
                        ),
                        title: const Text(
                          'Treatment Information',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TreatmentPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  // =================================================
                  // SKIN COUNSELING
                  // =================================================

                  DrawerMenuItem(
                    icon: Icons.face_retouching_natural_outlined,
                    title: 'Skin Counseling',
                    color: primaryColor,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SkinCounsellingPage(),
                        ),
                      );
                    },
                  ),

                  // =================================================
                  // CONTACT US
                  // =================================================

                  DrawerMenuItem(
                    icon: Icons.phone_outlined,
                    title: 'Contact Us',
                    color: primaryColor,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ContactUsPage(),
                        ),
                      );
                    },
                  ),

                  // =================================================
                  // DIVIDER
                  // =================================================

                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    indent: 16,
                    endIndent: 16,
                  ),

                  // =================================================
                  // SETTINGS
                  // =================================================

                  DrawerMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    color: primaryColor,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // =================================================
            // BOTTOM SECTION
            // =================================================

            const Divider(),

            // =================================================
            // LANGUAGE
            // =================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              child: InkWell(
                onTap: showLanguageDialog,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFD4A373),
                        Color(0xFFE8C39E),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(
                          alpha: 0.25,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.language,
                        color: Colors.white,
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          selectedLanguage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // =================================================
            // LOGOUT
            // =================================================

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: showLogoutDialog,
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// REUSABLE DRAWER MENU ITEM
// =====================================================

class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1A2E),
        ),
      ),
      onTap: onTap,
    );
  }
}