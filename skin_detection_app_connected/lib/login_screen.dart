import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  final Widget homeScreen;

  const LoginScreen({
    super.key,
    required this.homeScreen,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController(text: 'alexisareao@gmail.com');
  // Password default set to admin as requested by user
  final TextEditingController _passwordController =
      TextEditingController(text: 'admin');

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goToCreateAccount() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeInOutCubic,
    );
  }

  void _goToWelcome() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _submitAuth() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String enteredPassword = _passwordController.text.trim();

    // Validate password (accepts 'admin' or '123456')
    if (enteredPassword != 'admin' && enteredPassword != '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Invalid password! Use default password: admin',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFFC85A32),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 650));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget.homeScreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Warm luxury peach-cream palette from reference design
    const Color bgCream = Color(0xFFFAF5EE);

    return Scaffold(
      backgroundColor: bgCream,
      body: SafeArea(
        top: false,
        bottom: true,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildWelcomeScreen(context),
            _buildCreateAccountScreen(context),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // SCREEN 1: WELCOME SCREEN (LEFT IN IMAGE)
  // ==========================================
  Widget _buildWelcomeScreen(BuildContext context) {
    const Color terracottaAccent = Color(0xFFE4AA93);
    const Color darkText = Color(0xFF1C1715);
    const Color subText = Color(0xFF332A26);
    const Color linkColor = Color(0xFFC77854);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // --- TOP ORGANIC VISUAL & MODEL IMAGE ---
                  SizedBox(
                    height: constraints.maxHeight * 0.54,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background organic terracotta blob
                        Positioned(
                          top: constraints.maxHeight * 0.08,
                          left: 45,
                          right: 35,
                          bottom: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              color: terracottaAccent.withValues(alpha: 0.72),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(160),
                                topRight: Radius.circular(190),
                                bottomLeft: Radius.circular(140),
                                bottomRight: Radius.circular(190),
                              ),
                            ),
                          ),
                        ),

                        // Model portrait with smooth fade into cream background
                        Positioned.fill(
                          top: constraints.maxHeight * 0.04,
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 0.68, 0.88, 1.0],
                                colors: [
                                  Colors.black,
                                  Colors.black,
                                  Colors.black54,
                                  Colors.transparent,
                                ],
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.asset(
                              'assets/images/skincare_model.jpg',
                              fit: BoxFit.contain,
                              alignment: Alignment.topCenter,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.face_retouching_natural,
                                    size: 100,
                                    color: terracottaAccent,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Top bar credit tag matching the reference (@timothy_aboh)
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 8,
                          left: 20,
                          child: Text(
                            '@timothy_aboh',
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              color: const Color(0xFFBBB3AB),
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // --- MIDDLE TEXT: "Dual-lens Dermatologist" ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Dual-lens',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 38,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                            letterSpacing: -0.5,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Dermatologist',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 38,
                                fontWeight: FontWeight.w700,
                                color: darkText,
                                letterSpacing: -0.5,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(width: 6),
                            // Leaf flourish accent
                            CustomPaint(
                              size: const Size(18, 18),
                              painter: _PetalFlourishPainter(
                                color: terracottaAccent,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 26),

                        // Subtitle: "Start your skincare journey with us!"
                        Text(
                          'Start your skincare journey\nwith us!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: subText,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // --- BOTTOM ACTION: "Sign In" BUTTON ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _goToCreateAccount,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF111111),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // "Already have an account? Log in"
                        GestureDetector(
                          onTap: _goToCreateAccount,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: const Color(0xFF8A827C),
                                ),
                                children: const [
                                  TextSpan(
                                    text: 'Already have an account? ',
                                  ),
                                  TextSpan(
                                    text: 'Log in',
                                    style: TextStyle(
                                      color: linkColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ==========================================
  // SCREEN 2: CREATE AN ACCOUNT (RIGHT IN IMAGE)
  // ==========================================
  Widget _buildCreateAccountScreen(BuildContext context) {
    const Color darkText = Color(0xFF1C1715);
    const Color bodyText = Color(0xFF423A36);
    const Color inputLabel = Color(0xFF2C2522);
    const Color fieldBorder = Color(0xFFD3C8BE);
    const Color linkColor = Color(0xFFC77854);
    const Color socialBg = Color(0xFFECE7E1);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 10),

                  // Top bar with back arrow
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _goToWelcome,
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: Color(0xFF4A423E),
                        ),
                        splashRadius: 20,
                        tooltip: 'Back to Welcome',
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // --- TITLE WITH ACCENT CIRCLE / BLUSH ---
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 2,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE4AA93).withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                      Text(
                        'Create an Account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // --- SUBTITLE PARAGRAPH ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Your journey, your choice! Introducing a personalized blend of gentle Homeopathic wisdom and advanced Allopathic precision for complete skin care.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: bodyText,
                        height: 1.48,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // --- INPUT 1: Your Email Address ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Email Address',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: inputLabel,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.dmSans(
                      fontSize: 14.5,
                      color: const Color(0xFF766E68),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFAF7F2),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: fieldBorder,
                          width: 1.2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: fieldBorder,
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0xFF111111),
                          width: 1.4,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // --- INPUT 2: Create a Password (Default: admin) ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create a Password',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: inputLabel,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: GoogleFonts.dmSans(
                      fontSize: 14.5,
                      color: const Color(0xFF766E68),
                      letterSpacing: _obscurePassword ? 2.5 : 0.2,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFAF7F2),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                          color: const Color(0xFF8A827C),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: fieldBorder,
                          width: 1.2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: fieldBorder,
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color(0xFF111111),
                          width: 1.4,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 22),

                  // --- PRIMARY BUTTON: "Create an account" ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitAuth,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF111111),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Create an account',
                              style: GoogleFonts.dmSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // "Already have an account? Log in"
                  GestureDetector(
                    onTap: _submitAuth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: const Color(0xFF8A827C),
                          ),
                          children: const [
                            TextSpan(
                              text: 'Already have an account? ',
                            ),
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                color: linkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- SOCIAL BUTTON 1: "Sign up with Apple" ---
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _submitAuth,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: socialBg,
                        foregroundColor: const Color(0xFF22201E),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.apple,
                            size: 22,
                            color: Color(0xFF1A1817),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Sign up with Apple',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF22201E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // --- SOCIAL BUTTON 2: "Sign up with Google" ---
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _submitAuth,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: socialBg,
                        foregroundColor: const Color(0xFF22201E),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Clean custom Google 'G' icon
                          CustomPaint(
                            size: const Size(18, 18),
                            painter: _GoogleGIconPainter(),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Sign up with Google',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF22201E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ==========================================
// CUSTOM PAINTER: PETAL FLOURISH ACCENT
// ==========================================
class _PetalFlourishPainter extends CustomPainter {
  final Color color;

  _PetalFlourishPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    // Elegant tilted leaf/petal shape
    path.moveTo(size.width * 0.1, size.height * 0.9);
    path.quadraticBezierTo(
      size.width * 0.05,
      size.height * 0.3,
      size.width * 0.95,
      size.height * 0.05,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.85,
      size.width * 0.1,
      size.height * 0.9,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// CUSTOM PAINTER: GOOGLE "G" LOGO
// ==========================================
class _GoogleGIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Rect rect = Rect.fromLTWH(0, 0, w, h);

    final Paint paintBlue = Paint()..color = const Color(0xFF4285F4);
    final Paint paintGreen = Paint()..color = const Color(0xFF34A853);
    final Paint paintYellow = Paint()..color = const Color(0xFFFBBC05);
    final Paint paintRed = Paint()..color = const Color(0xFFEA4335);

    final Paint strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.22;

    // Draw Google arcs
    // Red arc (top)
    strokePaint.color = paintRed.color;
    canvas.drawArc(rect.deflate(w * 0.11), 3.14 * 1.15, 3.14 * 0.7, false, strokePaint);

    // Yellow arc (left)
    strokePaint.color = paintYellow.color;
    canvas.drawArc(rect.deflate(w * 0.11), 3.14 * 0.65, 3.14 * 0.5, false, strokePaint);

    // Green arc (bottom)
    strokePaint.color = paintGreen.color;
    canvas.drawArc(rect.deflate(w * 0.11), 3.14 * 0.1, 3.14 * 0.55, false, strokePaint);

    // Blue bar & arc (right & center)
    strokePaint.color = paintBlue.color;
    canvas.drawArc(rect.deflate(w * 0.11), -3.14 * 0.15, 3.14 * 0.35, false, strokePaint);

    final Paint barPaint = Paint()
      ..color = paintBlue.color
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.45, h * 0.41, w * 0.52, h * 0.20),
        const Radius.circular(1.5),
      ),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}