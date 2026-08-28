import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
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

// 0. स्प्लैश स्क्रीन
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

    Future.delayed(const Duration(milliseconds: 3000), () {
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
                height: 130,
                width: 130,
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
                        Icons.account_balance_wallet,
                        size: 60,
                        color: Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            ScaleTransition(
              scale: _animation,
              child: const Text('LALA LOAN',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      letterSpacing: 3)),
            ),
            const SizedBox(height: 10),
            const Text('Your Trusted Financial Partner',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 50),
            const CircularProgressIndicator(color: Colors.redAccent),
          ],
        ),
      ),
    );
  }
}

// 1. लॉगिन स्क्रीन
class InviteLoginScreen extends StatefulWidget {
  const InviteLoginScreen({super.key});

  @override
  State<InviteLoginScreen> createState() => _InviteLoginScreenState();
}

class _InviteLoginScreenState extends State<InviteLoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestAllPermissions();
  }

  Future<void> requestAllPermissions() async {
    await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
    ].request();
  }

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

    if (inviteCode != "LALA123") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Invalid Invite Code! (Use: LALA123)'),
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
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 2)),
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        letterSpacing: 2)),
                const SizedBox(height: 8),
                const Text('Invite Only Access',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                const SizedBox(height: 35),
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
                      labelText: 'Invite Code (Use: LALA123)',
                      prefixIcon: const Icon(Icons.vpn_key, color: Colors.red),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2))),
                ),
                const SizedBox(height: 30),
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

// 2. मेन डैशबोर्ड
class MainDashboardScreen extends StatefulWidget {
  final String userPhone;
  const MainDashboardScreen({super.key, required this.userPhone});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _selectedIndex = 0;
  String currentStatus = 'NO ACTIVE LOAN';
  double loanAmount = 0.0;
  String loanBasis = '-';

  void onLoanApplied(double amount, String basis) {
    setState(() {
      loanAmount = amount;
      loanBasis = basis == 'documents' ? 'Document Based' : 'Collateral Based';
      currentStatus = 'PENDING APPROVAL';
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ApplyLoanTab(userPhone: widget.userPhone, onApplyComplete: onLoanApplied),
      MyLoansTab(amount: loanAmount, basis: loanBasis, status: currentStatus),
      ProfileTab(userPhone: widget.userPhone),
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
                  setState(() => _selectedIndex = 0);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.history, color: Colors.white),
                title: const Text('My Loans',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                selected: _selectedIndex == 1,
                selectedTileColor: Colors.red.withOpacity(0.2),
                onTap: () {
                  setState(() => _selectedIndex = 1);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text('Profile',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                selected: _selectedIndex == 2,
                selectedTileColor: Colors.red.withOpacity(0.2),
                onTap: () {
                  setState(() => _selectedIndex = 2);
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
                  setState(() => _selectedIndex = 3);
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

// 3. लोन अप्लाई फॉर्म (बैंक, खाता संख्या, IFSC, UPI फील्ड्स के साथ)
class ApplyLoanTab extends StatefulWidget {
  final String userPhone;
  final Function(double, String) onApplyComplete;
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
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController upiController = TextEditingController();

  File? aadhaarFile;
  File? panFile;
  File? lightBillFile;
  File? pledgedFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(String docType, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        if (docType == 'aadhaar') aadhaarFile = File(image.path);
        if (docType == 'pan') panFile = File(image.path);
        if (docType == 'lightbill') lightBillFile = File(image.path);
        if (docType == 'pledged') pledgedFile = File(image.path);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Photo attached successfully!'),
            backgroundColor: Colors.green));
      }
    }
  }

  void _showSourceDialog(String docType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Select Option', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.red),
                title: const Text('Take Photo', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(docType, ImageSource.camera);
                }),
            ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.red),
                title: const Text('Choose from Gallery', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(docType, ImageSource.gallery);
                }),
          ],
        ),
      ),
    );
  }

  void applyForLoan() {
    if (selectedLoanBasis == 'documents') {
      if (aadhaarFile == null || panFile == null || lightBillFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please upload all 3 required documents!'),
            backgroundColor: Colors.redAccent));
        return;
      }
    } else {
      if (itemValueController.text.trim().isEmpty || pledgedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please provide item value and photo!'),
            backgroundColor: Colors.redAccent));
        return;
      }
    }

    if (bankNameController.text.trim().isEmpty ||
        accountNumberController.text.trim().isEmpty ||
        ifscController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill Bank Name, Account Number and IFSC Code!'),
          backgroundColor: Colors.redAccent));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoanSuccessScreen(
              amount: selectedAmount, loanBasis: selectedLoanBasis)),
    ).then((_) {
      widget.onApplyComplete(selectedAmount, selectedLoanBasis);
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.grey[900]!, Colors.black]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.redAccent, width: 2)),
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
                        fontSize: 34,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                    ]),
                Slider(
                    value: selectedInterestRate,
                    min: 5.0,
                    max: 36.0,
                    divisions: 31,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey[800],
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
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Loan Tenure',
                          style: TextStyle(color: Colors.grey)),
                      Text('$selectedTenureMonths Months',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                    ]),
                Slider(
                    value: selectedTenureMonths.toDouble(),
                    min: 1,
                    max: 36,
                    divisions: 35,
                    activeColor: Colors.red,
                    inactiveColor: Colors.grey[800],
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
            padding: const EdgeInsets.all(16),
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold))
                    ]),
                const Divider(color: Colors.grey, height: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Interest:',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('₹ ${totalInterest.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.bold))
                    ]),
                const SizedBox(height: 6),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Payable:',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('₹ ${totalPayable.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold))
                    ]),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text('Select Loan Type',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12)),
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
                    onChanged: (value) =>
                        setState(() => selectedLoanBasis = value!)),
                RadioListTile<String>(
                    title: const Text('Collateral Based',
                        style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Pledge Gold, Mobile or Vehicles',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    value: 'collateral',
                    groupValue: selectedLoanBasis,
                    activeColor: Colors.red,
                    onChanged: (value) =>
                        setState(() => selectedLoanBasis = value!)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (selectedLoanBasis == 'documents') ...[
            _buildUploadButton('ID Proof', aadhaarFile != null,
                () => _showSourceDialog('aadhaar')),
            const SizedBox(height: 10),
            _buildUploadButton(
                'PAN Card', panFile != null, () => _showSourceDialog('pan')),
            const SizedBox(height: 10),
            _buildUploadButton('Light Bill', lightBillFile != null,
                () => _showSourceDialog('lightbill')),
          ] else ...[
            TextField(
                controller: itemValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Estimated Item Value (₹)',
                    prefixIcon:
                        const Icon(Icons.currency_rupee, color: Colors.red),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 10),
            _buildUploadButton('Pledged Item Photo', pledgedFile != null,
                () => _showSourceDialog('pledged')),
          ],
          const SizedBox(height: 25),
          const Text('Bank & Payout Details',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 12),
          TextField(
            controller: bankNameController,
            decoration: InputDecoration(
              labelText: 'Bank Name (e.g., SBI, HDFC, BOB)',
              prefixIcon: const Icon(Icons.account_balance, color: Colors.red),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: accountNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Bank Account Number',
              prefixIcon: const Icon(Icons.pin, color: Colors.red),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: ifscController,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: 'IFSC Code',
              prefixIcon: const Icon(Icons.code, color: Colors.red),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: upiController,
            decoration: InputDecoration(
              labelText: 'UPI ID (Optional - e.g., lala@okaxis)',
              prefixIcon: const Icon(Icons.payment, color: Colors.red),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2)),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: applyForLoan,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
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
      label: Text(isUploaded ? '$title (Attached ✓)' : 'Attach $title',
          style: TextStyle(
              color: isUploaded ? Colors.greenAccent : Colors.white,
              fontSize: 15)),
      style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: isUploaded ? Colors.greenAccent : Colors.red, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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

// 4. My Loans पेज
class MyLoansTab extends StatelessWidget {
  final double amount;
  final String basis;
  final String status;

  const MyLoansTab(
      {super.key,
      required this.amount,
      required this.basis,
      required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'PENDING APPROVAL'
        ? Colors.orangeAccent
        : Colors.grey;

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
                border: Border.all(color: statusColor, width: 1.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(basis,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14)),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(status,
                              style: TextStyle(
                                  color: statusColor,
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
                const Text(
                    'Your application has been registered successfully and is under internal review.',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 5. प्रोफाइल पेज
class ProfileTab extends StatelessWidget {
  final String userPhone;
  const ProfileTab({super.key, required this.userPhone});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 3)),
              child: ClipOval(
                  child: Image.asset('assets/logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.person,
                          size: 55,
                          color: Colors.red))),
            ),
          ),
          const SizedBox(height: 16),
          const Text('LALA DON',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 4),
          const Text('Trusted Member',
              style: TextStyle(fontSize: 14, color: Colors.greenAccent)),
          const SizedBox(height: 35),
          _buildProfileItem(Icons.phone, 'Phone Number', '+91 $userPhone'),
          _buildProfileItem(Icons.security, 'Account Status', 'Verified'),
          _buildProfileItem(Icons.star, 'CIBIL Score', 'Good (750+)'),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(icon, color: Colors.red, size: 26),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))
        ])
      ]),
    );
  }
}

// 6. कस्टमर सपोर्ट पेज
class SupportTab extends StatelessWidget {
  const SupportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.headset_mic, size: 70, color: Colors.redAccent),
          const SizedBox(height: 20),
          const Text('Need Help?',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          const Text('Our support team is available 24/7.',
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(14)),
            child: const Row(
              children: [
                Icon(Icons.phone_in_talk, color: Colors.greenAccent, size: 28),
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
                            fontSize: 16,
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

// 7. लोन सबमिट सक्सेस स्क्रीन
class LoanSuccessScreen extends StatelessWidget {
  final double amount;
  final String loanBasis;
  const LoanSuccessScreen(
      {super.key, required this.amount, required this.loanBasis});

  @override
  Widget build(BuildContext context) {
    String basisText =
        loanBasis == 'documents' ? 'Document Based' : 'Collateral Based';
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.greenAccent, size: 100),
              const SizedBox(height: 30),
              const Text('Application Submitted!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 12),
              Text(
                  'Your application for ₹${amount.toStringAsFixed(0)} ($basisText) has been submitted successfully.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.grey)),
              const SizedBox(height: 40),
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
