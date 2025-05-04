import 'package:flutter/material.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  final String payeeInfo;
  final String amount;
  final String paymentMethod;

  const PaymentConfirmationScreen({
    super.key,
    required this.payeeInfo,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  State<PaymentConfirmationScreen> createState() => _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  final TextEditingController pinController = TextEditingController();
  bool isAuthenticating = false;
  String? authError;

  void _authenticateAndProcessPayment() async {
    setState(() {
      isAuthenticating = true;
      authError = null;
    });

    // Simulate authentication delay
    await Future.delayed(Duration(seconds: 2));

    // For demo, accept PIN "1234" as valid
    if (pinController.text == '1234') {
      // TODO: Implement actual payment processing logic here

      setState(() {
        isAuthenticating = false;
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Your payment to ${widget.payeeInfo} of \$${widget.amount} was successful.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil((route) => route.isFirst); // Go back to home or main screen
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        isAuthenticating = false;
        authError = 'Invalid PIN. Please try again.';
      });
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Payment'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Please confirm your payment details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Payee'),
              subtitle: Text(widget.payeeInfo),
            ),
            ListTile(
              title: Text('Amount'),
              subtitle: Text('\$${widget.amount}'),
            ),
            ListTile(
              title: Text('Payment Method'),
              subtitle: Text(widget.paymentMethod),
            ),
            SizedBox(height: 24),
            TextField(
              controller: pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: 'Enter PIN to authorize',
                errorText: authError,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            isAuthenticating
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _authenticateAndProcessPayment,
                    child: Text('Confirm Payment'),
                  ),
          ],
        ),
      ),
    );
  }
}
