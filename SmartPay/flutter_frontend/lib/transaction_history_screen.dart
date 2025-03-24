import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'account_details_screen.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  int _selectedIndex = 2; // Start on Transactions tab

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AccountDetailsScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // Sample transaction data
  final List<Map<String, String>> transactions = [
    {
      'date': '2025-02-21',
      'description': 'Payment to ABC Store',
      'amount': '₹1,500',
      'status': 'Completed'
    },
    {
      'date': '2025-02-18',
      'description': 'Received from XYZ Pvt Ltd',
      'amount': '₹5,000',
      'status': 'Completed'
    },
    {
      'date': '2025-02-15',
      'description': 'Payment to DEF Online',
      'amount': '₹2,200',
      'status': 'Pending'
    },
    {
      'date': '2025-02-10',
      'description': 'Received from GHI Ltd',
      'amount': '₹3,500',
      'status': 'Completed'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text("Transaction History", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 20),
            // Wrap ListView with Scrollbar widget
            Expanded(
              child: Scrollbar(
                thumbVisibility: true, // This will make the scrollbar visible at all times
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: const Icon(
                          Icons.attach_money,
                          color: Color(0xFF1E3A8A),
                        ),
                        title: Text(
                          transaction['description']!,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Date: ${transaction['date']}\nStatus: ${transaction['status']}",
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        trailing: Text(
                          transaction['amount']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: transaction['status'] == 'Completed'
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
}
