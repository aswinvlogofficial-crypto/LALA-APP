import 'package:flutter/material.dart';

void main() {
  runApp(const LalaApp());
}

class LalaApp extends StatelessWidget {
  const LalaApp({super.key});

  static const Color navyBg = Color(0xFF071126);
  static const Color navyCard = Color(0xFF0E1D3D);
  static const Color navySurface = Color(0xFF152954);
  static const Color goldAccent = Color(0xFFE5B84B);
  static const Color goldSoft = Color(0xFFF3D27A);

  @override
  Widget build(BuildContext context) {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: goldAccent,
      brightness: Brightness.dark,
      primary: goldAccent,
      onPrimary: navyBg,
      secondary: goldSoft,
      surface: navyCard,
    );

    return MaterialApp(
      title: 'LALA APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: baseScheme,
        scaffoldBackgroundColor: navyBg,
        cardColor: navyCard,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: navyBg,
          foregroundColor: goldSoft,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: navySurface,
          labelStyle: const TextStyle(color: Colors.white70),
          hintStyle: const TextStyle(color: Colors.white38),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: goldAccent.withValues(alpha: 0.35)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: goldAccent, width: 1.8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: goldAccent,
            foregroundColor: navyBg,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _inviteController = TextEditingController();

  static const String requiredInviteCode = 'LALA123';
  double _slideValue = 0.0;
  String _statusMessage = '';

  @override
  void dispose() {
    _phoneController.dispose();
    _inviteController.dispose();
    super.dispose();
  }

  void _attemptEnterApp() {
    final String phone = _phoneController.text.trim();
    final String invite = _inviteController.text.trim().toUpperCase();

    if (phone.length < 10) {
      setState(() {
        _slideValue = 0.0;
        _statusMessage = 'Sahi phone number (kam se kam 10 ank) daalein.';
      });
      return;
    }

    if (invite != requiredInviteCode) {
      setState(() {
        _slideValue = 0.0;
        _statusMessage =
            'Galat Invite Code! Sirf reference code $requiredInviteCode se entry milegi.';
      });
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MainDashboard(userPhone: phone),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: LalaApp.navyCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: LalaApp.goldAccent.withValues(alpha: 0.45),
                  ),
                ),
                child: Column(
                  children: const [
                    Icon(
                      Icons.shield_moon_rounded,
                      size: 54,
                      color: LalaApp.goldAccent,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'LALA APP',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: LalaApp.goldSoft,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Navy & Gold Edition • Invite Only',
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '9876543210',
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: LalaApp.goldAccent,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _inviteController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Invite Code',
                  hintText: 'LALA123',
                  prefixIcon: Icon(
                    Icons.vpn_key_rounded,
                    color: LalaApp.goldAccent,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: LalaApp.navyCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: LalaApp.goldAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Slide to Login',
                          style: TextStyle(
                            color: LalaApp.goldSoft,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Ant tak slide karein',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                    Slider(
                      value: _slideValue,
                      min: 0.0,
                      max: 1.0,
                      activeColor: LalaApp.goldAccent,
                      inactiveColor: LalaApp.navySurface,
                      onChanged: (val) {
                        setState(() {
                          _slideValue = val;
                          _statusMessage = '';
                        });
                      },
                      onChangeEnd: (val) {
                        if (val >= 0.85) {
                          setState(() => _slideValue = 1.0);
                          _attemptEnterApp();
                        } else {
                          setState(() => _slideValue = 0.0);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _attemptEnterApp,
                child: const Text('Unlock & Login'),
              ),
              if (_statusMessage.isNotEmpty) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    _statusMessage,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class MainDashboard extends StatefulWidget {
  final String userPhone;

  const MainDashboard({super.key, required this.userPhone});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  String _savedSummary = 'Abhi koi Bank ya UPI detail save nahi hui hai.';

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      LoanCalculatorTab(
        onSavePaymentSummary: (summary) {
          setState(() {
            _savedSummary = summary;
            _selectedIndex = 1;
          });
        },
      ),
      ProfileAndPaymentTab(
        userPhone: widget.userPhone,
        paymentSummary: _savedSummary,
        onUpdateSummary: (summary) {
          setState(() => _savedSummary = summary);
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LALA APP',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              backgroundColor: LalaApp.navySurface,
              side: BorderSide(
                color: LalaApp.goldAccent.withValues(alpha: 0.4),
              ),
              label: const Text(
                'VIP • LALA123',
                style: TextStyle(
                  color: LalaApp.goldSoft,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: LalaApp.navyCard,
        indicatorColor: LalaApp.goldAccent.withValues(alpha: 0.22),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate, color: LalaApp.goldAccent),
            label: 'Loan',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(
              Icons.account_balance_wallet,
              color: LalaApp.goldAccent,
            ),
            label: 'Bank & Profile',
          ),
        ],
      ),
    );
  }
}

class LoanCalculatorTab extends StatefulWidget {
  final ValueChanged<String> onSavePaymentSummary;

  const LoanCalculatorTab({super.key, required this.onSavePaymentSummary});

  @override
  State<LoanCalculatorTab> createState() => _LoanCalculatorTabState();
}

class _LoanCalculatorTabState extends State<LoanCalculatorTab> {
  double _amount = 25000;
  double _interestRate = 14;
  int _tenureMonths = 12;

  final TextEditingController _bankNameCtrl = TextEditingController();
  final TextEditingController _accountNoCtrl = TextEditingController();
  final TextEditingController _ifscCtrl = TextEditingController();
  final TextEditingController _upiIdCtrl = TextEditingController();

  @override
  void dispose() {
    _bankNameCtrl.dispose();
    _accountNoCtrl.dispose();
    _ifscCtrl.dispose();
    _upiIdCtrl.dispose();
    super.dispose();
  }

  double get _estimatedTotalPayable {
    final double yearlyInterest =
        _amount * (_interestRate / 100.0) * (_tenureMonths / 12.0);
    return _amount + yearlyInterest;
  }

  double get _estimatedMonthlyPayment {
    return _estimatedTotalPayable / _tenureMonths;
  }

  void _savePayoutDetails() {
    final String bank = _bankNameCtrl.text.trim();
    final String acc = _accountNoCtrl.text.trim();
    final String ifsc = _ifscCtrl.text.trim().toUpperCase();
    final String upi = _upiIdCtrl.text.trim();

    if (acc.isEmpty && upi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kam se kam Account Number ya UPI ID daalein.'),
        ),
      );
      return;
    }

    final List<String> parts = [];
    if (bank.isNotEmpty) parts.add('Bank: $bank');
    if (acc.isNotEmpty) parts.add('A/C: $acc');
    if (ifsc.isNotEmpty) parts.add('IFSC: $ifsc');
    if (upi.isNotEmpty) parts.add('UPI: $upi');

    widget.onSavePaymentSummary(parts.join(' | '));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bank & UPI payout details save ho gayi hain!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: LalaApp.navyCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: LalaApp.goldAccent.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.bolt_rounded, color: LalaApp.goldAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Approval Status: Few Minutes (Fast Reference Review)',
                    style: TextStyle(
                      color: LalaApp.goldSoft,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: LalaApp.navyCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Loan Amount',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: LalaApp.goldSoft,
                      ),
                    ),
                    Text(
                      '₹${_amount.round()}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: LalaApp.goldSoft,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: _amount,
                  min: 1,
                  max: 100000,
                  divisions: 1000,
                  activeColor: LalaApp.goldAccent,
                  onChanged: (val) => setState(() => _amount = val),
                ),
                const SizedBox(height: 8),
                Text(
                  'Interest Rate: ${_interestRate.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: LalaApp.goldSoft,
                  ),
                ),
                Slider(
                  value: _interestRate,
                  min: 1,
                  max: 60,
                  divisions: 59,
                  activeColor: LalaApp.goldAccent,
                  onChanged: (val) => setState(() => _interestRate = val),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tenure: $_tenureMonths Months',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Slider(
                  value: _tenureMonths.toDouble(),
                  min: 3,
                  max: 36,
                  divisions: 33,
                  activeColor: LalaApp.goldSoft,
                  onChanged: (val) => setState(() => _tenureMonths = val.round()),
                ),
                const Divider(height: 24, color: Colors.white12),
                Text(
                  'Approx. Monthly Installment: ₹${_estimatedMonthlyPayment.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total Estimated Payable: ₹${_estimatedTotalPayable.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: LalaApp.navyCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: LalaApp.goldAccent.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Bank Account & UPI Details',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: LalaApp.goldSoft,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _bankNameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Bank Name',
                    hintText: 'HDFC / SBI / ICICI',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _accountNoCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Account Number',
                    hintText: 'Account number daalein',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _ifscCtrl,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: 'IFSC Code',
                    hintText: 'HDFC0001234',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _upiIdCtrl,
                  decoration: const InputDecoration(
                    labelText: 'UPI ID',
                    hintText: 'yourname@upi',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _savePayoutDetails,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Save Bank & UPI Details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileAndPaymentTab extends StatelessWidget {
  final String userPhone;
  final String paymentSummary;
  final ValueChanged<String> onUpdateSummary;

  const ProfileAndPaymentTab({
    super.key,
    required this.userPhone,
    required this.paymentSummary,
    required this.onUpdateSummary,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: LalaApp.navyCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: LalaApp.goldAccent.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Member Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: LalaApp.goldSoft,
                ),
              ),
              const SizedBox(height: 10),
              Text('Phone: $userPhone', style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 4),
              const Text(
                'Access Mode: Invite-Only (LALA123)',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: LalaApp.navyCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Saved Bank / UPI Payout Info',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: LalaApp.goldSoft,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                paymentSummary,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: () {
                  onUpdateSummary(
                    'Abhi koi Bank ya UPI detail save nahi hui hai.',
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: LalaApp.goldSoft,
                  side: const BorderSide(color: LalaApp.goldAccent),
                ),
                child: const Text('Clear Saved Details'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
