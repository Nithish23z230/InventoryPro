import 'dart:math'; // For generating OTP
import 'package:flutter/material.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  String otp = ""; // Holds the generated OTP

  // Function to generate a new OTP
  void generateOTP() {
    setState(() {
      otp = (1000 + Random().nextInt(9000)).toString(); // Generates a 4-digit OTP
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Your Bank",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
            const SizedBox(height: 10),
            const Text("Enter your mobile number to continue", style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 30),
            
            // Phone Number Input
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              maxLength: 10, // Restrict to 10 digits
              decoration: const InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                counterText: "", // Hides character count display
              ),
            ),

            const SizedBox(height: 10),

            // OTP Display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "OTP: $otp",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                ElevatedButton(
                  onPressed: generateOTP,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text("Generate OTP"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Send OTP Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (phoneController.text.length == 10) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPScreen(phone: phoneController.text, otp: otp),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a valid 10-digit phone number")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Send OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
