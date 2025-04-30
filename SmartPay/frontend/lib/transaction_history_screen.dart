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
  int _selectedIndex = 2;
  String _selectedMonth = 'All';
  String _selectedYear = 'All';

  final List<Map<String, String>> _allTransactions = [
    {
      'date': '2025-02-21',
      'description': 'Payment to ABC Store',
      'amount': '₹1,500',
      'status': 'Completed',
      'sender': 'John'
    },
    {
      'date': '2025-02-18',
      'description': 'Received from XYZ Pvt Ltd',
      'amount': '₹5,000',
      'status': 'Completed',
      'sender': 'Alice'
    },
    {
      'date': '2025-02-15',
      'description': 'Payment to DEF Online',
      'amount': '₹2,200',
      'status': 'Pending',
      'sender': 'Bob'
    },
    {
      'date': '2025-01-25',
      'description': 'Payment to JKL Store',
      'amount': '₹3,000',
      'status': 'Completed',
      'sender': 'Eve'
    },
    {
      'date': '2025-01-20',
      'description': 'Received from LMN Pvt Ltd',
      'amount': '₹8,000',
      'status': 'Completed',
      'sender': 'Liam'
    },
    {
      'date': '2024-12-15',
      'description': 'Received from STU Ltd',
      'amount': '₹7,000',
      'status': 'Completed',
      'sender': 'Ethan'
    },
  ];

  List<Map<String, String>> getFilteredTransactions() {
    return _allTransactions.where((transaction) {
      final date = transaction['date']!;
      final year = date.substring(0, 4);
      final month = date.substring(5, 7);
      final matchesMonth = _selectedMonth == 'All' || _selectedMonth == month;
      final matchesYear = _selectedYear == 'All' || _selectedYear == year;
      return matchesMonth && matchesYear;
    }).toList();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AccountDetailsScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF4A90E2),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF6AB7FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedMonth,
                  onChanged: (value) => setState(() => _selectedMonth = value!),
                  items: <String>[
                    'All', '01', '02', '12'
                  ].map<DropdownMenuItem<String>>((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month == 'All'
                          ? 'All Months'
                          : {
                              '01': 'January',
                              '02': 'February',
                              '12': 'December',
                            }[month]!),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 20),
                DropdownButton<String>(
                  value: _selectedYear,
                  onChanged: (value) => setState(() => _selectedYear = value!),
                  items: <String>[
                    'All', '2024', '2025'
                  ].map<DropdownMenuItem<String>>((String year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(year == 'All' ? 'All Years' : year),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 4.0,
                      color: Color(0x33000000),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(height: 3, color: const Color(0xFF4A90E2), width: 120),
            const SizedBox(height: 20),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: getFilteredTransactions().length,
                  itemBuilder: (context, index) {
                    final transaction = getFilteredTransactions()[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFF4A90E2),
                          child: Text(
                            transaction['sender']![0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          transaction['description']!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Date: ${transaction['date']}\nStatus: ${transaction['status']}",
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        trailing: Text(
                          transaction['amount']!,
                          style: TextStyle(
                            fontSize: 18,
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
