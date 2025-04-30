import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Import your dashboard screen

void main() {
  runApp(const BankingApp());
}

class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartPay',
      theme: ThemeData(
        primaryColor: const Color(0xFF1E3A8A),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1E3A8A),
          surface: Color(0xFFFAFAFA),
        ),
      ),
      home: const DashboardScreen(), // ✅ Set Dashboard as initial screen
    );
  }
}
