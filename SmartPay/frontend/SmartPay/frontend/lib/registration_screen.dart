import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import login screen for navigation
import 'enter_banking_details_screen.dart'; // Import the banking details screen

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> registerUser() async {
    await Future.delayed(const Duration(seconds: 2));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('User registered successfully!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/darkbluebg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue, Colors.white.withOpacity(0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    "SmartPay",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintText: "Enter your username",
                            hintStyle: const TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.person, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintText: "Enter your email",
                            hintStyle: const TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.email, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintText: "Enter your password",
                            hintStyle: const TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.lock, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                          ),
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: isLoading ? null : () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              registerUser().then((_) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            side: BorderSide(color: Colors.white.withOpacity(0.6)),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Register',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                        ),

                        const SizedBox(height: 20),

                        /// 🚨 New Button: "Enter Banking Details"
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EnterBankingDetailsScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            side: BorderSide(color: Colors.white.withOpacity(0.6)),
                          ),
                          child: const Text(
                            'Enter Banking Details',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? ", style: TextStyle(color: Colors.white)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
