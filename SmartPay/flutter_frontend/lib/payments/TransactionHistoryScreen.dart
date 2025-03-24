import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatefulWidget {
  final bool canCancelTransaction; // New Parameter

  // Constructor with default value
  const TransactionHistoryScreen({super.key, this.canCancelTransaction = false});

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  List<Map<String, dynamic>> transactions = [
    {"id": 1, "amount": 500, "receiver": "John", "canCancel": true},
    {"id": 2, "amount": 200, "receiver": "Alice", "canCancel": false},
    {"id": 3, "amount": 1000, "receiver": "Bob", "canCancel": true},
  ];

  void _cancelTransaction(int id) {
    setState(() {
      transactions.removeWhere((transaction) => transaction["id"] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Transaction $id has been canceled!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text("Sent to ${transaction["receiver"]}"),
            subtitle: Text("Amount: ₹${transaction["amount"]}"),
            trailing: widget.canCancelTransaction && transaction["canCancel"]
                ? IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () => _cancelTransaction(transaction["id"]),
                  )
                : null,
          );
        },
      ),
    );
  }
}
