import 'package:flutter/material.dart';

class PayUPIScreen extends StatefulWidget {
  const PayUPIScreen({super.key});

  @override
  _PayUPIScreenState createState() => _PayUPIScreenState();
}

class _PayUPIScreenState extends State<PayUPIScreen> {
  final TextEditingController upiController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  void _performTransaction() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UPI Payment Successful!")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay via UPI"), backgroundColor: const Color(0xFF1E3A8A)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // UPI ID Input
            TextField(
              controller: upiController,
              decoration: InputDecoration(
                labelText: "Enter UPI ID",
                prefixIcon: const Icon(Icons.payment),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
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
