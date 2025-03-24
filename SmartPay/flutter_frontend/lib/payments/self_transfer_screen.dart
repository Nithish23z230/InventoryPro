import 'package:flutter/material.dart';

class SelfTransferScreen extends StatefulWidget {
  const SelfTransferScreen({super.key});

  @override
  _SelfTransferScreenState createState() => _SelfTransferScreenState();
}

class _SelfTransferScreenState extends State<SelfTransferScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  String? selectedAccount; // Dropdown for selecting the account

  void _performTransaction() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Self Transfer Successful!")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Self Transfer"), backgroundColor: const Color(0xFF1E3A8A)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Account Selection (Dropdown)
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Account",
                prefixIcon: const Icon(Icons.account_balance_wallet),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              value: selectedAccount,
              items: ["Savings Account", "Current Account"]
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) => setState(() => selectedAccount = value),
            ),
            const SizedBox(height: 15),

            // Amount Input
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Amount",
                prefixIcon: const Icon(Icons.currency_rupee),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),

            // PIN Input
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Enter PIN",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 25),

            // Submit Button
            ElevatedButton(
              onPressed: _performTransaction,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Transfer", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
