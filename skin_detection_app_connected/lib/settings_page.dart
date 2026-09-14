import 'package:flutter/material.dart';
import 'account_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD4A373),
        foregroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Account Management Card
          _buildSettingsCard(
            context,
            icon: Icons.person_outline,
            title: 'Account Management',
            subtitle: 'Manage your account settings',
            color: const Color(0xFFD4A373),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          
          // Logout Card
          _buildSettingsCard(
            context,
            icon: Icons.logout,
            title: 'Logout',
            subtitle: 'Sign out from your account',
            color: Colors.red,
            onTap: () => _showLogoutDialog(context),
          ),
          const SizedBox(height: 16),
          
          // Notifications Card
          _buildSettingsCard(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage notification preferences',
            color: const Color(0xFF22C55E),
            onTap: () {
              _showComingSoonDialog(context, 'Notifications');
            },
          ),
          const SizedBox(height: 16),
          
          // Privacy Policy Card
          _buildSettingsCard(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'View privacy policy',
            color: const Color(0xFFF59E0B),
            onTap: () {
              _showComingSoonDialog(context, 'Privacy Policy');
            },
          ),
          const SizedBox(height: 16),
          
          // Help & Support Card
          _buildSettingsCard(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help and support',
            color: const Color(0xFF8B5CF6),
            onTap: () {
              _showComingSoonDialog(context, 'Help & Support');
            },
          ),
          const SizedBox(height: 16),
          
          // About Card
          _buildSettingsCard(
            context,
            icon: Icons.info_outline,
            title: 'About DermaScan AI',
            subtitle: 'Version 1.0.0',
            color: const Color(0xFF6366F1),
            onTap: () {
              _showAboutDialog(context);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
     shape: const RoundedRectangleBorder(
      
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
           color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A2E),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFFD4A373),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                _logout(context);
              },
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color(0xFFD4A373),
            ),
            SizedBox(height: 16),
            Text(
              'Logging out...',
              style: TextStyle(
                color: Color(0xFF1A1A2E),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (!context.mounted) return;
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Logged out successfully'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        if (!context.mounted) return;
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    });
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Coming Soon!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '$feature feature will be available in the next update.',
            style: const TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFFD4A373),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'About DermaScan AI',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Version: 1.0.0',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 8),
              Text(
                'Skin Disease Detection App using AI',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 8),
              Text(
                '© 2026 DermaScan AI. All rights reserved.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFFD4A373),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}