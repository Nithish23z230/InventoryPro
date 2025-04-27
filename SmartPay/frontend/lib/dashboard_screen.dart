import 'package:flutter/material.dart';
import 'account_details_screen.dart';

// Import all payment screens
import 'payments/qr_scanner_screen.dart';
import 'payments/pay_contacts_screen.dart';
import 'payments/pay_phone_screen.dart';
import 'payments/bank_transfer_screen.dart';
import 'payments/pay_upi_screen.dart';
import 'payments/self_transfer_screen.dart';

// Import Self-Help Group screen
import 'payments/self_help_groups.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AccountDetailsScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildQuickActionButton(
      String text, IconData icon, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: Colors.blue[900]!),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue[900], size: 28),
          const SizedBox(height: 5),
          Text(text, style: TextStyle(color: Colors.blue[900], fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search by phone number, UPI ID, or name",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
                children: [
                  _buildQuickActionButton("Scan QR", Icons.qr_code_scanner, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QRScannerScreen()));
                  }),
                  _buildQuickActionButton("Pay Contacts", Icons.contacts, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PayContactsScreen()));
                  }),
                  _buildQuickActionButton("Pay Phone", Icons.phone, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PayPhoneScreen()));
                  }),
                  _buildQuickActionButton(
                      "Bank Transfer", Icons.account_balance, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BankTransferScreen()));
                  }),
                  _buildQuickActionButton("Pay UPI ID", Icons.payment, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PayUPIScreen()));
                  }),
                  _buildQuickActionButton("Self Transfer", Icons.swap_horiz,
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelfTransferScreen()));
                  }),
                  _buildQuickActionButton("Self-Help Group", Icons.groups, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelfHelpGroupScreen()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
