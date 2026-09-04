import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LALA App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();

  void _login() {
    if (_phoneController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LALA Loan Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const LoanCalculatorPage(),
    const PaymentSetupPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Loan Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Payment Details',
          ),
        ],
      ),
    );
  }
}

class LoanCalculatorPage extends StatefulWidget {
  const LoanCalculatorPage({super.key});

  @override
  State<LoanCalculatorPage> createState() => _LoanCalculatorPageState();
}

class _LoanCalculatorPageState extends State<LoanCalculatorPage> {
  final _amountController = TextEditingController();
  final _monthsController = TextEditingController();
  double _emi = 0.0;

  void _calculateEMI() {
    double? principal = double.tryParse(_amountController.text);
    double? months = double.tryParse(_monthsController.text);

    if (principal != null && months != null && months > 0) {
      setState(() {
        _emi = principal / months;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loan Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Loan Amount'),
            ),
            TextField(
              controller: _monthsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Months'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateEMI,
              child: const Text('Calculate EMI'),
            ),
            const SizedBox(height: 20),
            Text(
              'Monthly EMI: ₹$_emi',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSetupPage extends StatefulWidget {
  const PaymentSetupPage({super.key});

  @override
  State<PaymentSetupPage> createState() => _PaymentSetupPageState();
}

class _PaymentSetupPageState extends State<PaymentSetupPage> {
  final _bankNameController = TextEditingController();
  final _accountNoController = TextEditingController();
  final _ifscController = TextEditingController();
  final _upiController = TextEditingController();

  void _savePaymentDetails() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment details saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Bank & UPI Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _bankNameController,
                decoration: const InputDecoration(labelText: 'Bank Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _accountNoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Account Number'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ifscController,
                decoration: const InputDecoration(labelText: 'IFSC Code'),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              TextField(
                controller: _upiController,
                decoration: const InputDecoration(labelText: 'UPI ID (e.g. ybl@upi)'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _savePaymentDetails,
                child: const Text('Save Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
