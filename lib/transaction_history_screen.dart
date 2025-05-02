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
  String _searchQuery = '';
  String _sortOption = 'Date: Newest';

  final List<Map<String, String>> _allTransactions = [
    {
      'date': '2025-02-21',
      'description': 'Payment to ABC Store',
      'amount': '₹1,500',
      'status': 'Completed',
      'sender': 'John',
      'type': 'sent',
    },
    {
      'date': '2025-02-18',
      'description': 'Received from XYZ Pvt Ltd',
      'amount': '₹5,000',
      'status': 'Completed',
      'sender': 'Alice',
      'type': 'received',
    },
    {
      'date': '2025-02-15',
      'description': 'Payment to DEF Online',
      'amount': '₹2,200',
      'status': 'Completed',
      'sender': 'Bob',
      'type': 'sent',
    },
    {
      'date': '2025-01-25',
      'description': 'Payment to JKL Store',
      'amount': '₹3,000',
      'status': 'Completed',
      'sender': 'Eve',
      'type': 'sent',
    },
    {
      'date': '2025-01-20',
      'description': 'Received from LMN Pvt Ltd',
      'amount': '₹8,000',
      'status': 'Completed',
      'sender': 'Liam',
      'type': 'received',
    },
    {
      'date': '2024-12-15',
      'description': 'Received from STU Ltd',
      'amount': '₹7,000',
      'status': 'Completed',
      'sender': 'Ethan',
      'type': 'received',
    },
  ];

  List<Map<String, String>> getFilteredTransactions() {
    List<Map<String, String>> filtered = _allTransactions.where((transaction) {
      final date = transaction['date']!;
      final year = date.substring(0, 4);
      final month = date.substring(5, 7);
      final matchesMonth = _selectedMonth == 'All' || _selectedMonth == month;
      final matchesYear = _selectedYear == 'All' || _selectedYear == year;
      final matchesSearch = _searchQuery.isEmpty ||
          transaction['description']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          transaction['sender']!.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesMonth && matchesYear && matchesSearch;
    }).toList();

    switch (_sortOption) {
      case 'Date: Newest':
        filtered.sort((a, b) => b['date']!.compareTo(a['date']!));
        break;
      case 'Date: Oldest':
        filtered.sort((a, b) => a['date']!.compareTo(b['date']!));
        break;
      case 'Amount: High to Low':
        filtered.sort((a, b) =>
            int.parse(b['amount']!.replaceAll(RegExp(r'[^0-9]'), '')).compareTo(
                int.parse(a['amount']!.replaceAll(RegExp(r'[^0-9]'), ''))));
        break;
      case 'Amount: Low to High':
        filtered.sort((a, b) =>
            int.parse(a['amount']!.replaceAll(RegExp(r'[^0-9]'), '')).compareTo(
                int.parse(b['amount']!.replaceAll(RegExp(r'[^0-9]'), ''))));
        break;
    }
    return filtered;
  }

  int getTotalAmount() {
    int balance = 0;
    for (var transaction in getFilteredTransactions()) {
      if (transaction['status'] == 'Completed') {
        int amount = int.parse(transaction['amount']!.replaceAll(RegExp(r'[^0-9]'), ''));
        if (transaction['type'] == 'received') {
          balance += amount;
        } else if (transaction['type'] == 'sent') {
          balance -= amount;
        }
      }
    }
    return balance;
  }

  int getSumOfTransactions() {
    int sum = 0;
    for (var transaction in getFilteredTransactions()) {
      if (transaction['status'] == 'Completed') {
        sum += int.parse(transaction['amount']!.replaceAll(RegExp(r'[^0-9]'), ''));
      }
    }
    return sum;
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

  Future<void> _refreshTransactions() async {
    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // In real app, fetch new data here
    });
  }

  void _showTransactionDetails(Map<String, String> transaction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(transaction['description']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${transaction['date']}'),
              Text('Amount: ${transaction['amount']}'),
              Text('Status: ${transaction['status']}'),
              Text('Sender: ${transaction['sender']}'),
              Text('Type: ${transaction['type'] == 'sent' ? 'Sent' : 'Received'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Icon _getTransactionIcon(String type) {
    switch (type) {
      case 'sent':
        return const Icon(Icons.arrow_upward, color: Colors.red);
      case 'received':
        return const Icon(Icons.arrow_downward, color: Colors.red);
      default:
        return const Icon(Icons.help_outline, color: Colors.grey);
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = getFilteredTransactions();
    final totalAmount = getTotalAmount();

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
      backgroundColor: const Color(0xFF003366),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003366), Color(0xFF004080)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTransactions,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Summary Section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Total Transactions',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          filteredTransactions.length.toString(),
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Remaining Balance',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          '₹$totalAmount',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Sum of Transactions',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          '₹${getSumOfTransactions()}',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Filters and Search Row
              Row(
                children: [
                  DropdownButton<String>(
                    value: _selectedMonth,
                    onChanged: (value) => setState(() => _selectedMonth = value!),
                    items: <String>[
                      'All',
                      '01',
                      '02',
                      '12'
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
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _selectedYear,
                    onChanged: (value) => setState(() => _selectedYear = value!),
                    items: <String>[
                      'All',
                      '2024',
                      '2025'
                    ].map<DropdownMenuItem<String>>((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year == 'All' ? 'All Years' : year),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _sortOption,
                    onChanged: (value) => setState(() => _sortOption = value!),
                    items: <String>[
                      'Date: Newest',
                      'Date: Oldest',
                      'Amount: High to Low',
                      'Amount: Low to High',
                    ].map<DropdownMenuItem<String>>((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
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
                child: filteredTransactions.isEmpty
                    ? const Center(
                        child: Text(
                          'No transactions found.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: filteredTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction = filteredTransactions[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                onTap: () => _showTransactionDetails(transaction),
                                contentPadding: const EdgeInsets.all(16),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xFF4A90E2),
                                  child: _getTransactionIcon(transaction['type']!),
                                ),
                                title: Text(
                                  transaction['description']!,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Date: ${transaction['date']}\nStatus: ${transaction['status']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _getStatusColor(transaction['status']!),
                                  ),
                                ),
                                trailing: Text(
                                  transaction['amount']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(transaction['status']!),
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
