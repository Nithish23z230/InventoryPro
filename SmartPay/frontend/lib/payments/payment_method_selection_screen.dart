import 'package:flutter/material.dart';
import 'payment_confirmation_screen.dart';

class PaymentMethodSelectionScreen extends StatefulWidget {
  final String payeeInfo;
  final String amount;

  const PaymentMethodSelectionScreen({
    super.key,
    required this.payeeInfo,
    required this.amount,
  });

  @override
  State<PaymentMethodSelectionScreen> createState() => _PaymentMethodSelectionScreenState();
}

class _PaymentMethodSelectionScreenState extends State<PaymentMethodSelectionScreen> {
  String? selectedPaymentMethod;

  final List<String> paymentMethods = [
    'Linked Bank Account',
    'Credit Card',
    'In-App Balance',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Payee: ${widget.payeeInfo}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Amount: \$${widget.amount}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  final method = paymentMethods[index];
                  return RadioListTile<String>(
                    title: Text(method),
                    value: method,
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: selectedPaymentMethod == null
                  ? null
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentConfirmationScreen(
                            payeeInfo: widget.payeeInfo,
                            amount: widget.amount,
                            paymentMethod: selectedPaymentMethod!,
                          ),
                        ),
                      );
                    },
              child: const Text('Confirm Payment Method'),
            ),
          ],
        ),
      ),
    );
  }
}
