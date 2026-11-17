import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ---------- रंग (Colors) ----------
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
      title: 'LALA APP',
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

// ---------- स्लाइड लॉगिन पेज (Slide-to-Login & Invite Code) ----------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _inviteController = TextEditingController();
  late final AnimationController _anim;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  bool _isSliderUnlocked = false;
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

  void _attemptLogin() {
    final phone = _phoneController.text.trim();
    if (phone.length != 10) {
      _showMsg('कृपया 10 अंकों का सही फ़ोन नंबर डालें');
      setState(() => _isSliderUnlocked = false);
      return;
    }
    if (_inviteController.text.trim() != validInviteCode) {
      _showMsg('गलत इनवाइट कोड। एक्सेस नहीं मिला।');
      setState(() => _isSliderUnlocked = false);
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
                        child: const Icon(
                          Icons.security,
                          color: kGold,
                          size: 44,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'LALA APP',
                        style: TextStyle(
                          color: kGold,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Own by Lala • Exclusive Access',
                        style: TextStyle(color: kTextDim, fontSize: 14),
                      ),
                      const SizedBox(height: 36),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          labelText: 'फ़ोन नंबर (Phone Number)',
                          prefixIcon: Icon(Icons.phone_outlined, color: kGold),
                          counterText: '',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _inviteController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          labelText: 'इनवाइट कोड (Invite Code: LALA123)',
                          prefixIcon: Icon(Icons.vpn_key_outlined, color: kGold),
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Slide to Login Interactive Component
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: kCard,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: kGold.withOpacity(0.5)),
                        ),
                        child: Stack(
                          children: [
                            const Center(
                              child: Text(
                                '>>> Slide to Login LALA APP >>>',
                                style: TextStyle(color: kTextDim, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              left: _isSliderUnlocked ? 230 : 0,
                              child: GestureDetector(
                                onHorizontalDragUpdate: (details) {
                                  if (details.delta.dx > 5) {
                                    setState(() {
                                      _isSliderUnlocked = true;
                                    });
                                    _attemptLogin();
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: kGold,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Icon(Icons.arrow_forward_ios, color: kNavy),
                                ),
                              ),
                            ),
                          ],
                        ),
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

// ---------- मुख्य होम स्क्रीन (Main Navigation & Tabs) ----------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    LoanCalculatorTab(),
    StreamingTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LALA APP - DASHBOARD'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate, color: kGold),
            label: 'Loan & Calc',
          ),
          NavigationDestination(
            icon: Icon(Icons.live_tv_outlined),
            selectedIcon: Icon(Icons.live_tv, color: kGold),
            label: 'Streaming',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: kGold),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ---------- 1. लोन कैलकुलेटर टैब (1-1L Amount, 1-60% Interest, Few Minutes Status) ----------
class LoanCalculatorTab extends StatefulWidget {
  const LoanCalculatorTab({super.key});

  @override
  State<LoanCalculatorTab> createState() => _LoanCalculatorTabState();
}

class _LoanCalculatorTabState extends State<LoanCalculatorTab> {
  double _loanAmount = 25000.0; // ₹1 to ₹1,00,000
  double _interestRate = 12.0;  // 1% to 60%
  bool _isSubmitting = false;
  String _approvalMessage = '';

  void _submitLoan() {
    setState(() {
      _isSubmitting = true;
      _approvalMessage = '';
    });

    // Realistic processing delay without fixed 10s timer
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSubmitting = false;
        _approvalMessage = 'Loan Application Submitted Successfully!\nYour loan will be approved in Few Minutes.';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'स्मार्ट लोन कैलकुलेटर (Loan & Interest)',
          style: TextStyle(color: kGold, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        
        // Loan Amount Card
        Card(
          color: kCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.between,
                  children: [
                    const Text('लोन राशि (Loan Amount)', style: TextStyle(color: kTextDim)),
                    Text('₹${_loanAmount.toStringAsFixed(0)}', style: const TextStyle(color: kGold, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Slider(
                  value: _loanAmount,
                  min: 1,
                  max: 100000,
                  divisions: 99999,
                  activeColor: kGold,
                  inactiveColor: kNavy,
                  onChanged: (val) => setState(() => _loanAmount = val),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Interest Rate Card (1% to 60%)
        Card(
          color: kCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.between,
                  children: [
                    const Text('ब्याज दर (Interest Rate)', style: TextStyle(color: kTextDim)),
                    Text('${_interestRate.toStringAsFixed(1)}% p.a.', style: const TextStyle(color: kGoldSoft, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Slider(
                  value: _interestRate,
                  min: 1.0,
                  max: 60.0,
                  divisions: 59,
                  activeColor: kGoldSoft,
                  inactiveColor: kNavy,
                  onChanged: (val) => setState(() => _interestRate = val),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitLoan,
          child: _isSubmitting
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: kNavy, strokeWidth: 2))
              : const Text('लोन के लिए आवेदन करें (Apply Now)'),
        ),
        const SizedBox(height: 20),

        if (_approvalMessage.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kGold, width: 1),
            ),
            child: Text(
              _approvalMessage,
              style: const TextStyle(color: kGoldSoft, fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

// ---------- 2. स्ट्रीमिंग टैब (LALA DON GAMING Streaming Hub) ----------
class StreamingTab extends StatelessWidget {
  const StreamingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LALA DON GAMING - Live Feeds', style: TextStyle(color: kGold, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: kGold.withOpacity(0.3)),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.videocam_outlined, size: 64, color: kGold),
                    SizedBox(height: 12),
                    Text('OBS Stream Integration Active', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kText)),
                    SizedBox(height: 6),
                    Text('Free Fire & GTA V Live Streaming Ready', style: TextStyle(color: kTextDim, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- 3. प्रोफाइल टैब (Lala Don Profile & Settings) ----------
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: kCard,
            child: Icon(Icons.person, size: 50, color: kGold),
          ),
          const SizedBox(height: 14),
          const Text('Lala Don (Nishad Aswin)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kGold)),
          const Text('Owner • LALA APP & LALA DON GAMING', style: TextStyle(color: kTextDim, fontSize: 13)),
          const SizedBox(height: 30),
          Card(
            color: kCard,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.cloud_done, color: kGold),
                  title: const Text('Cloud Membership Status'),
                  trailing: const Text('Active', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                ),
                const Divider(color: kNavy),
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: kGold),
                  title: const Text('Camera & Auto-Upload Handler'),
                  subtitle: const Text('Permissions & background upload configured'),
                  trailing: const Icon(Icons.check_circle, color: Colors.greenAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
