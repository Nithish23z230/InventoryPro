import 'package:flutter/material.dart';

class PayContactsScreen extends StatefulWidget {
  const PayContactsScreen({super.key});

  @override
  _PayContactsScreenState createState() => _PayContactsScreenState();
}

class _PayContactsScreenState extends State<PayContactsScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  String? selectedContact; // Dummy variable for contact selection

  void _performTransaction() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Transaction Successful!")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Pay Contacts"), backgroundColor: const Color(0xFF1E3A8A)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Contact Selection (Dummy Dropdown)
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Contact",
                prefixIcon: const Icon(Icons.contacts),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              value: selectedContact,
              items: ["Aldric Anto", "Harish", "Nithesh"]
                  .map((name) =>
                      DropdownMenuItem(value: name, child: Text(name)))
                  .toList(),
              onChanged: (value) => setState(() => selectedContact = value),
            ),
            const SizedBox(height: 15),

            // Amount Input
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Amount",
                prefixIcon: const Icon(Icons.currency_rupee),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 25),

            // Submit Button
            ElevatedButton(
              onPressed: _performTransaction,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Transfer",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
