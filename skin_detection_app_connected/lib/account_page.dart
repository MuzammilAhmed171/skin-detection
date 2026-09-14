import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isDeactivated = false;
  int _remainingDays = 15;

  @override
  void initState() {
    super.initState();
    _checkAccountStatus();
  }

  void _checkAccountStatus() {
    setState(() {
      _isDeactivated = false;
      _remainingDays = 15;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        title: const Text(
          'Account Management',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildAccountStatusCard(),
            const SizedBox(height: 24),
            _buildDeleteAccountSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountStatusCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _isDeactivated 
                        ? Colors.orange.withValues(alpha: 0.1)
                       : Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _isDeactivated 
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle,
                    color: _isDeactivated ? Colors.orange : Colors.green,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isDeactivated ? 'Account Deactivated' : 'Account Active',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isDeactivated 
                            ? 'Your account will be deleted in $_remainingDays days'
                            : 'Your account is active and secure',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_isDeactivated) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.2),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Login within 15 days to reactivate your account automatically',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteAccountSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
               color: Colors.red.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                 color: Colors.red.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    icon: Icons.timer_outlined,
                    text: 'Account will be deactivated for 15 days',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    icon: Icons.refresh,
                    text: 'Re-login within 15 days to reactivate',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    icon: Icons.delete_sweep,
                    text: 'All user data will be permanently deleted after 15 days',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    icon: Icons.person_add,
                    text: 'Need to sign-up as new user after deletion',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isDeactivated ? null : _showDeleteConfirmationDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isDeactivated ? Colors.grey : Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  disabledBackgroundColor: Colors.grey[300],
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Text(
                  _isDeactivated ? 'Account Already Deactivated' : 'Delete My Account',
                ),
              ),
            ),
            
            if (!_isDeactivated) ...[
              const SizedBox(height: 12),
              const Text(
                '⚠️ This action cannot be undone. Please be certain.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
         title: const Row(
           children: [
             Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 28,
              ),
               SizedBox(width: 10),
              Text(
                'Delete Account?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Text('Are you sure you want to delete your account?'),
              SizedBox(height: 12),
              Text(
                '⚠️ This action cannot be undone.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Your account will be deactivated for 15 days. You can reactivate by logging in during this period.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF6C63FF),
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
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                _deleteAccount(context);
              },
              child: const Text(
                'Delete Account',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color(0xFF6C63FF),
            ),
            SizedBox(height: 16),
            Text(
              'Deactivating account...',
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

    Future.delayed(const Duration(seconds: 2), () {
     if (!context.mounted) return;
      Navigator.pop(context);
      setState(() {
        _isDeactivated = true;
        _remainingDays = 15;
      });
if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Account deactivated for 15 days'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          duration: Duration(seconds: 3),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (!context.mounted) return;
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    });
  }
}