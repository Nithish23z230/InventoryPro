import 'package:flutter/material.dart';

class SelfHelpGroupScreen extends StatefulWidget {
  const SelfHelpGroupScreen({super.key});

  @override
  _SelfHelpGroupScreenState createState() => _SelfHelpGroupScreenState();
}

class _SelfHelpGroupScreenState extends State<SelfHelpGroupScreen> {
  final List<String> members = [];
  double groupBalance = 0.0;

  void _addMember(String name) {
    setState(() {
      members.add(name);
    });
  }

  void _depositMoney(double amount) {
    setState(() {
      groupBalance += amount;
    });
  }

  void _withdrawMoney(double amount) {
    if (amount <= groupBalance) {
      setState(() {
        groupBalance -= amount;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient funds!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Self Help Group"),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Group Balance: \$${groupBalance.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Member Name'),
            ),
            ElevatedButton(
              onPressed: () {
                _addMember(nameController.text);
                nameController.clear();
              },
              child: const Text("Add Member"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _depositMoney(double.parse(amountController.text));
                    amountController.clear();
                  },
                  child: const Text("Deposit"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _withdrawMoney(double.parse(amountController.text));
                    amountController.clear();
                  },
                  child: const Text("Withdraw"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Members:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) =>
                    ListTile(title: Text(members[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
