import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(const LalaLoanApp());
}

class LalaLoanApp extends StatelessWidget {
  const LalaLoanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// 0. स्प्लैश स्क्रीन (Splash Screen)
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();

    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const InviteLoginScreen()));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 3),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.red.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 5)
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.local_fire_department,
                        size: 70,
                        color: Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ScaleTransition(
              scale: _animation,
              child: const Text('LALA LOAN',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      letterSpacing: 3)),
            ),
            const SizedBox(height: 10),
            const Text('Your Trusted Financial Partner',
                style: TextStyle(
                    fontSize: 14, color: Colors.grey, letterSpacing: 1)),
            const SizedBox(height: 60),
            const CircularProgressIndicator(color: Colors.redAccent),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 1. लॉगिन स्क्रीन
// ==========================================
class InviteLoginScreen extends StatefulWidget {
  const InviteLoginScreen({super.key});

  @override
  State<InviteLoginScreen> createState() => _InviteLoginScreenState();
}

class _InviteLoginScreenState extends State<InviteLoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();
  final String validInviteCode = "LALA123";
  final String adminSecretPin = "7777";

  void handleLogin() {
    String phone = phoneController.text.trim();
    String inviteCode = inviteCodeController.text.trim();

    if (phone.isEmpty || phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid 10-digit Phone Number!'),
            backgroundColor: Colors.redAccent),
      );
      return;
    }

    if (inviteCode == adminSecretPin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
      );
      return;
    }

    if (inviteCode.isEmpty || inviteCode != validInviteCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Invalid Invite Code! (Customer: LALA123 | Admin: 7777)'),
            backgroundColor: Colors.redAccent),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MainDashboardScreen(userPhone: phone)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 2),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red.withOpacity(0.5),
                              blurRadius: 12,
                              spreadRadius: 2)
                        ]),
                    child: ClipOval(
                      child: Image.asset('assets/logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                  child: Text('LALA',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)))),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('LALA LOAN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        letterSpacing: 2)),
                const SizedBox(height: 8),
                const Text('For invited members only',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 40),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                      counterText: "",
                      labelText: 'Phone Number',
                      prefixIcon: const Icon(Icons.phone, color: Colors.red),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2))),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: inviteCodeController,
                  decoration: InputDecoration(
                      labelText: 'Invite Code / Admin Pin (Try: 7777)',
                      prefixIcon: const Icon(Icons.vpn_key, color: Colors.red),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2))),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: const Text('Login',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// ग्लोबल लोन डेटा स्टोरेज
// ==========================================
List<Map<String, dynamic>> globalLoanRequests = [
  {
    'id': '1',
    'phone': '9876543210',
    'amount': 25000.0,
    'basis': 'Document Based',
    'status': 'PENDING',
    'details': 'Aadhaar, PAN & Light Bill Uploaded'
  },
  {
    'id': '2',
    'phone': '9123456789',
    'amount': 50000.0,
    'basis': 'Collateral Based',
    'status': 'PENDING',
    'details': 'Gold Ring (Value: ₹ 60,000)'
  },
];

// ==========================================
// 2. मेन डैशबोर्ड
// ==========================================
class MainDashboardScreen extends StatefulWidget {
  final String userPhone;
  const MainDashboardScreen({super.key, required this.userPhone});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;
  bool hasPendingLoan = false;
  double pendingAmount = 0.0;
  String pendingBasis = '';

  Future<void> sendDataToRenderServer(
      double amount, String basis, String details) async {
    try {
      final httpClient = HttpClient();
      httpClient.badCertificateCallback = (cert, host, port) => true;

      // Render लाइव सर्वर लिंक
      final request = await httpClient.postUrl(
        Uri.parse('https://lala-loan-server.onrender.com/api/apply-loan'),
      );

      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(jsonEncode({
        'phone': widget.userPhone,
        'amount': amount,
        'basis': basis,
        'details': details,
        'time': DateTime.now().toString(),
      })));

      final response = await request.close();
      if (response.statusCode == 200) {
        print("🔥 [सफलता]: डेटा आपके ऑनलाइन Render सर्वर पर भेज दिया गया है!");
      } else {
        print("⚠️ [सर्वर एरर]: ${response.statusCode}");
      }
      httpClient.close();
    } catch (e) {
      print("❌ [कनेक्शन एरर]: $e");
    }
  }

  void onLoanApplied(double amount, String basis, String details) {
    setState(() {
      hasPendingLoan = true;
      pendingAmount = amount;
      pendingBasis = basis;
      _selectedIndex = 1;

      globalLoanRequests.insert(0, {
        'id': DateTime.now().toString(),
        'phone': widget.userPhone,
        'amount': amount,
        'basis': basis == 'documents' ? 'Document Based' : 'Collateral Based',
        'status': 'PENDING',
        'details': details,
      });
    });

    sendDataToRenderServer(amount, basis, details);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ApplyLoanTab(userPhone: widget.userPhone, onApplyComplete: onLoanApplied),
      MyLoansTab(
          hasPendingLoan: hasPendingLoan,
          amount: pendingAmount,
          basis: pendingBasis),
      const ProfileTab(),
      const SupportTab(),
    ];

    String appBarTitle = _selectedIndex == 0
        ? 'APPLY LOAN'
        : _selectedIndex == 1
            ? 'MY LOANS'
            : _selectedIndex == 2
                ? 'PROFILE'
                : 'CUSTOMER SUPPORT';

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(appBarTitle,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.red)),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              accountName: const Text('LALA DON',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              accountEmail: Text('+91 ${widget.userPhone}',
                  style: const TextStyle(color: Colors.grey)),
              currentAccountPicture: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 2)),
                  child: ClipOval(
                      child: Image.asset('assets/logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person,
                                  size: 40, color: Colors.red)))),
            ),
            ListTile(
                leading: const Icon(Icons.account_balance_wallet,
                    color: Colors.white),
                title: const Text('Apply for Loan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                selected: _selectedIndex == 0,
                selectedTileColor: Colors.red.withOpacity(0.2),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.history, color: Colors.white),
                title: const Text('My Loans',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                selected: _selectedIndex == 1,
                selectedTileColor: Colors.red.withOpacity(0.2),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text('Profile',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                selected: _selectedIndex == 2,
                selectedTileColor: Colors.red.withOpacity(0.2),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  Navigator.pop(context);
                }),
            ListTile(
                leading:
                    const Icon(Icons.support_agent, color: Colors.redAccent),
                title: const Text('Customer Support',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                selected: _selectedIndex == 3,
                selectedTileColor: Colors.red.withOpacity(0.2),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  Navigator.pop(context);
                }),
            const Divider(color: Colors.grey),
            ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InviteLoginScreen()));
                }),
          ],
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}

// ==========================================
// 3. एडमिन कंट्रोल पैनल
// ==========================================
class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  void _showUploadedDocsDialog(BuildContext context, String details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Uploaded Proofs & Documents',
            style: TextStyle(color: Colors.redAccent)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Details: $details',
                style: const TextStyle(color: Colors.white, fontSize: 15)),
            const SizedBox(height: 20),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red, width: 1.5),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified, color: Colors.greenAccent, size: 50),
                  SizedBox(height: 10),
                  Text('Verified Uploaded Image / Document',
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Text('(ID Proof / PAN / Collateral Item)',
                      style: TextStyle(color: Colors.white54, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('👑 LALA ADMIN CONTROL PANEL',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            tooltip: 'Exit',
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InviteLoginScreen()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: AdminStatCard(
                        title: 'Total Requests',
                        value: '${globalLoanRequests.length}',
                        color: Colors.redAccent)),
                const SizedBox(width: 12),
                Expanded(
                    child: AdminStatCard(
                        title: 'Active Control',
                        value: 'ONLINE',
                        color: Colors.greenAccent)),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Customer Loan Requests & Proofs',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: globalLoanRequests.length,
                itemBuilder: (context, index) {
                  var loan = globalLoanRequests[index];
                  String status = loan['status'];

                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.only(bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                            color: Colors.redAccent, width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Phone: +91 ${loan['phone']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16)),
                              Chip(
                                backgroundColor: status == 'APPROVED'
                                    ? Colors.green
                                    : (status == 'REJECTED'
                                        ? Colors.red
                                        : Colors.orange),
                                label: Text(status,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Amount: ₹ ${loan['amount']}',
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text('Basis: ${loan['basis']}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 13)),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                            onPressed: () {
                              _showUploadedDocsDialog(context, loan['details']);
                            },
                            icon: const Icon(Icons.remove_red_eye,
                                color: Colors.cyanAccent, size: 16),
                            label: const Text('View Uploaded Proofs & Photos',
                                style: TextStyle(
                                    color: Colors.cyanAccent, fontSize: 13)),
                            style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(color: Colors.cyanAccent)),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    globalLoanRequests[index]['status'] =
                                        'REJECTED';
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Loan Rejected!'),
                                          backgroundColor: Colors.red));
                                },
                                icon: const Icon(Icons.close,
                                    color: Colors.red, size: 18),
                                label: const Text('Reject',
                                    style: TextStyle(color: Colors.red)),
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.red)),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    globalLoanRequests[index]['status'] =
                                        'APPROVED';
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Loan Approved Successfully!'),
                                          backgroundColor: Colors.green));
                                },
                                icon: const Icon(Icons.check,
                                    color: Colors.white, size: 18),
                                label: const Text('Approve',
                                    style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const AdminStatCard(
      {super.key,
      required this.title,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ==========================================
// टैब 1: लोन अप्लाई करने वाला पेज
// ==========================================
class ApplyLoanTab extends StatefulWidget {
  final String userPhone;
  final Function(double, String, String) onApplyComplete;
  const ApplyLoanTab(
      {super.key, required this.userPhone, required this.onApplyComplete});

  @override
  State<ApplyLoanTab> createState() => _ApplyLoanTabState();
}

class _ApplyLoanTabState extends State<ApplyLoanTab> {
  double selectedAmount = 25000;
  double selectedInterestRate = 12.0;
  int selectedTenureMonths = 12;
  String selectedLoanBasis = 'documents';
  final TextEditingController itemValueController = TextEditingController();

  bool isAadhaarUploaded = false;
  bool isPanUploaded = false;
  bool isLightBillUploaded = false;
  bool isPledgedUploaded = false;

  void _simulateUpload(String docType) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            content: const Row(children: [
              CircularProgressIndicator(color: Colors.red),
              SizedBox(width: 20),
              Text('Uploading File...',
                  style: TextStyle(color: Colors.white, fontSize: 16))
            ])));
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      setState(() {
        if (docType == 'aadhaar') isAadhaarUploaded = true;
        if (docType == 'pan') isPanUploaded = true;
        if (docType == 'lightbill') isLightBillUploaded = true;
        if (docType == 'pledged') isPledgedUploaded = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Uploaded successfully!'),
          backgroundColor: Colors.green));
    });
  }

  void _showSourceDialog(String docType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title:
            const Text('Select Option', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.red),
                title: const Text('Take Photo',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _simulateUpload(docType);
                }),
            ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.red),
                title: const Text('Choose from Gallery',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _simulateUpload(docType);
                }),
          ],
        ),
      ),
    );
  }

  void applyForLoan() {
    String proofDetails = '';
    if (selectedLoanBasis == 'documents') {
      if (!isAadhaarUploaded || !isPanUploaded || !isLightBillUploaded) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error: Please upload ALL required documents first!'),
            backgroundColor: Colors.redAccent));
        return;
      }
      proofDetails = 'ID Proof, PAN Card & Light Bill Verified';
    } else {
      if (itemValueController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error: Please enter the estimated value!'),
            backgroundColor: Colors.redAccent));
        return;
      }
      if (!isPledgedUploaded) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error: Please upload a photo of the pledged item!'),
            backgroundColor: Colors.redAccent));
        return;
      }
      proofDetails =
          'Pledged Item Value: ₹${itemValueController.text} + Item Photo Uploaded';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoanSuccessScreen(
              amount: selectedAmount, loanBasis: selectedLoanBasis)),
    ).then((_) {
      widget.onApplyComplete(selectedAmount, selectedLoanBasis, proofDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    double monthlyRate = (selectedInterestRate / 100) / 12;
    int months = selectedTenureMonths;
    double periodicPayment = (monthlyRate > 0)
        ? (selectedAmount * monthlyRate * pow(1 + monthlyRate, months)) /
            (pow(1 + monthlyRate, months) - 1)
        : selectedAmount / months;
    double totalPayable = periodicPayment * months;
    double totalInterest = totalPayable - selectedAmount;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.grey[900]!, Colors.black]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.redAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5))
                ]),
            child: Column(
              children: [
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.currency_rupee, color: Colors.red, size: 22),
                      Text(' Selected Loan Amount',
                          style: TextStyle(color: Colors.grey, fontSize: 15))
                    ]),
                const SizedBox(height: 10),
                Text('₹ ${selectedAmount.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent)),
                Slider(
                    value: selectedAmount,
                    min: 1000,
                    max: 100000,
                    divisions: 99,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey[800],
                    label: '₹${selectedAmount.toStringAsFixed(0)}',
                    onChanged: (value) {
                      setState(() {
                        selectedAmount = value;
                      });
                    }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[800]!)),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Interest Rate (p.a.)',
                          style: TextStyle(color: Colors.grey)),
                      Text('${selectedInterestRate.toStringAsFixed(1)} %',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold))
                    ]),
                Slider(
                    value: selectedInterestRate,
                    min: 5.0,
                    max: 36.0,
                    divisions: 31,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey[800],
                    label: '${selectedInterestRate.toStringAsFixed(1)}%',
                    onChanged: (val) {
                      setState(() {
                        selectedInterestRate = val;
                      });
                    }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[800]!)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Loan Tenure',
                          style: TextStyle(color: Colors.grey)),
                      Text('$selectedTenureMonths Months',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold))
                    ]),
                Slider(
                    value: selectedTenureMonths.toDouble(),
                    min: 1,
                    max: 36,
                    divisions: 35,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey[800],
                    label: '$selectedTenureMonths Months',
                    onChanged: (val) {
                      setState(() {
                        selectedTenureMonths = val.toInt();
                      });
                    }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.redAccent, width: 1.5)),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Monthly EMI:',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text('₹ ${periodicPayment.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))
                    ]),
                const Divider(color: Colors.grey, height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Interest:',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('₹ ${totalInterest.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold))
                    ]),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Payable Amount:',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('₹ ${totalPayable.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                    ]),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text('Select Loan Basis',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[800]!)),
            child: Column(
              children: [
                RadioListTile<String>(
                    title: const Text('Document Based',
                        style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Upload ID Proof, PAN & Light Bill',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    value: 'documents',
                    groupValue: selectedLoanBasis,
                    activeColor: Colors.red,
                    onChanged: (value) {
                      setState(() {
                        selectedLoanBasis = value!;
                      });
                    }),
                const Divider(height: 1, color: Colors.grey),
                RadioListTile<String>(
                    title: const Text('Collateral Based',
                        style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Enter item value & capture photo',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    value: 'collateral',
                    groupValue: selectedLoanBasis,
                    activeColor: Colors.red,
                    onChanged: (value) {
                      setState(() {
                        selectedLoanBasis = value!;
                      });
                    }),
              ],
            ),
          ),
          const SizedBox(height: 25),
          if (selectedLoanBasis == 'documents') ...[
            const Text('Upload Required Documents',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 12),
            _buildUploadButton('ID Proof', isAadhaarUploaded,
                () => _showSourceDialog('aadhaar')),
            const SizedBox(height: 12),
            _buildUploadButton(
                'PAN Card', isPanUploaded, () => _showSourceDialog('pan')),
            const SizedBox(height: 12),
            _buildUploadButton('Light Bill', isLightBillUploaded,
                () => _showSourceDialog('lightbill')),
          ] else ...[
            const Text('Pledged Item Details',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 6),
            const Text('Enter estimated market value and take photo',
                style: TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 12),
            TextField(
                controller: itemValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Estimated Item Value (₹)',
                    labelStyle: const TextStyle(color: Colors.grey),
                    prefixIcon:
                        const Icon(Icons.currency_rupee, color: Colors.red),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2)))),
            const SizedBox(height: 12),
            _buildUploadButton('Pledged Item Photo', isPledgedUploaded,
                () => _showSourceDialog('pledged')),
          ],
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: applyForLoan,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14))),
            child: const Text('Apply Now',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton(
      String title, bool isUploaded, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(isUploaded ? Icons.check_circle : Icons.upload_file,
          color: isUploaded ? Colors.greenAccent : Colors.red),
      label: Text(isUploaded ? '$title (Uploaded ✓)' : 'Upload $title',
          style: TextStyle(
              color: isUploaded ? Colors.greenAccent : Colors.white,
              fontSize: 16)),
      style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: isUploaded ? Colors.greenAccent : Colors.red, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}

double pow(double base, int exponent) {
  double result = 1;
  for (int i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}

// ==========================================
// टैब 2: My Loans
// ==========================================
class MyLoansTab extends StatelessWidget {
  final bool hasPendingLoan;
  final double amount;
  final String basis;

  const MyLoansTab(
      {super.key,
      required this.hasPendingLoan,
      required this.amount,
      required this.basis});

  @override
  Widget build(BuildContext context) {
    if (!hasPendingLoan) {
      return const Center(
          child: Text('No Active Loans Yet.',
              style: TextStyle(color: Colors.grey, fontSize: 18)));
    }
    String basisText =
        basis == 'documents' ? 'Document Based' : 'Collateral Based';
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Active Applications',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orangeAccent, width: 1.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(basisText,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14)),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text('PENDING',
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)))
                    ]),
                const SizedBox(height: 12),
                Text('₹ ${amount.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 12),
                const Divider(color: Colors.grey),
                const SizedBox(height: 8),
                const Row(children: [
                  Icon(Icons.info_outline, color: Colors.grey, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                      child: Text(
                          'Under review by LALA LOAN admin. Reply expected within 24 hours.',
                          style: TextStyle(color: Colors.grey, fontSize: 12)))
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ==========================================
// टैब 3: प्रोफाइल पेज
// ==========================================
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 3)),
              child: ClipOval(
                  child: Image.asset('assets/logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.red))),
            ),
          ),
          const SizedBox(height: 16),
          const Text('LALA DON',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 4),
          const Text('Trusted Member',
              style: TextStyle(fontSize: 14, color: Colors.greenAccent)),
          const SizedBox(height: 40),
          _buildProfileItem(Icons.phone, 'Phone Number', '+91 98XXXXXX01'),
          _buildProfileItem(Icons.security, 'Account Status', 'Verified'),
          _buildProfileItem(Icons.star, 'CIBIL Score', 'Pending Check'),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(icon, color: Colors.red, size: 28),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))
        ])
      ]),
    );
  }
}

// ==========================================
// टैब 4: कस्टमर सपोर्ट पेज
// ==========================================
class SupportTab extends StatelessWidget {
  const SupportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.headset_mic, size: 80, color: Colors.redAccent),
          const SizedBox(height: 20),
          const Text('Need Help with Your Loan?',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 10),
          const Text(
              'Our customer support team is available 24/7 to help you out.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.redAccent.withOpacity(0.3))),
            child: const Row(
              children: [
                Icon(Icons.phone_in_talk, color: Colors.greenAccent, size: 30),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Helpline Number',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(height: 4),
                    Text('+91 98765 43210',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.redAccent.withOpacity(0.3))),
            child: const Row(
              children: [
                Icon(Icons.chat, color: Colors.green, size: 30),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('WhatsApp Support',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(height: 4),
                    Text('+91 98765 43210',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 10 सेकंड का टाइमर और सक्सेस स्क्रीन
// ==========================================
class LoanSuccessScreen extends StatefulWidget {
  final double amount;
  final String loanBasis;
  const LoanSuccessScreen(
      {super.key, required this.amount, required this.loanBasis});

  @override
  State<LoanSuccessScreen> createState() => _LoanSuccessScreenState();
}

class _LoanSuccessScreenState extends State<LoanSuccessScreen> {
  int _secondsRemaining = 10;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        if (_secondsRemaining > 1) {
          setState(() {
            _secondsRemaining--;
          });
          _startTimer();
        } else {
          setState(() {
            _isSubmitted = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String basisText =
        widget.loanBasis == 'documents' ? 'Document Based' : 'Collateral Based';
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: (_isSubmitted ? Colors.green : Colors.red)
                            .withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 10)
                  ]),
                  child: Icon(
                      _isSubmitted ? Icons.check_circle : Icons.hourglass_top,
                      color:
                          _isSubmitted ? Colors.greenAccent : Colors.redAccent,
                      size: 120)),
              const SizedBox(height: 40),
              Text(
                  _isSubmitted
                      ? 'Application Submitted!'
                      : 'Syncing with Server...',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 16),
              if (!_isSubmitted) ...[
                Text('Time remaining: ${_secondsRemaining}s',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, color: Colors.orangeAccent))
              ] else ...[
                Text(
                    'Your application for ₹${widget.amount.toStringAsFixed(0)} ($basisText) is submitted and under review.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.grey))
              ],
              const SizedBox(height: 50),
              if (_isSubmitted)
                OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.red),
                    label: const Text('Back to Dashboard',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
            ],
          ),
        ),
      ),
    );
  }
}
