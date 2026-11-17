import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ---------- रंग ----------
const Color kNavy = Color(0xFF0B1426);
const Color kNavyLight = Color(0xFF14213D);
const Color kCard = Color(0xFF1B2A4A);
const Color kGold = Color(0xFFD4AF37);
const Color kGoldSoft = Color(0xFFF2D675);
const Color kText = Color(0xFFF5F1E6);
const Color kTextDim = Color(0xFFA9B2C7);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LALA Loan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kNavy,
        colorScheme: const ColorScheme.dark(
          primary: kGold,
          onPrimary: kNavy,
          surface: kNavyLight,
          onSurface: kText,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        appBarTheme: const AppBarTheme(
          backgroundColor: kNavy,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: kGold,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kCard,
          labelStyle: const TextStyle(color: kTextDim),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: kGold, width: 1.5),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kGold,
            foregroundColor: kNavy,
            minimumSize: const Size.fromHeight(54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: kNavyLight,
          indicatorColor: kGold.withOpacity(0.2),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(color: kText, fontSize: 12),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ---------- लॉगिन ----------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _inviteController = TextEditingController();
  late final AnimationController _anim;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  // अभी इनवाइट कोड ऐप में है। बाद में सर्वर से चेक होगा।
  final String validInviteCode = "LALA123";

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic));
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    _phoneController.dispose();
    _inviteController.dispose();
    super.dispose();
  }

  void _showMsg(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: kCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  void _login() {
    final phone = _phoneController.text.trim();
    if (phone.length != 10) {
      _showMsg('कृपया 10 अंकों का सही फ़ोन नंबर डालें');
      return;
    }
    if (_inviteController.text.trim() != validInviteCode) {
      _showMsg('गलत इनवाइट कोड। एक्सेस नहीं मिला।');
      return;
    }
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kNavyLight, kNavy],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kCard,
                          border: Border.all(color: kGold, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: kGold.withOpacity(0.25),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.account_balance,
                              color: kGold,
                              size: 44,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'LALA LOAN',
                        style: TextStyle(
                          color: kGold,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'केवल इनवाइट के ज़रिए प्रवेश',
                        style: TextStyle(color: kTextDim, fontSize: 14),
                      ),
                      const SizedBox(height: 36),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          labelText: 'फ़ोन नंबर',
                          prefixIcon: Icon(Icons.phone_outlined, color: kGold),
                          counterText: '',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _inviteController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          labelText: 'इनवाइट कोड',
                          prefixIcon: Icon(Icons.vpn_key_outlined, color: kGold),
                        ),
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton(
                        onPressed: _login,
                        child: const Text('लॉगिन करें'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}