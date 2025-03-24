import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'transaction_history_screen.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  int _selectedIndex = 1;  // Start on Profile tab

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final String accountHolder = "John Doe";
  final String maskedAccountNumber = "**** **** **** 1234";
  final String accountType = "Savings Account";
  final String balance = "₹50,000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text("Account Details", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Account Holder Section
            _buildSectionTitle("Account Holder"),
            _buildSectionValue(accountHolder),
            const SizedBox(height: 20),

            // Account Number Section
            _buildSectionTitle("Account Number"),
            _buildSectionValue(maskedAccountNumber),
            const SizedBox(height: 20),

            // Account Type Section
            _buildSectionTitle("Account Type"),
            _buildSectionValue(accountType),
            const SizedBox(height: 20),

            // Balance Section
            _buildSectionTitle("Balance"),
            Text(
              balance,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF8B4513)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Transactions'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[700]),
    );
  }

  Widget _buildSectionValue(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
