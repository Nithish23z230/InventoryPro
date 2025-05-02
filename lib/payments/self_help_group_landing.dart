import 'package:flutter/material.dart';
import 'self_help_groups.dart';

class SelfHelpGroupLanding extends StatelessWidget {
  SelfHelpGroupLanding({super.key});

  final List<Map<String, dynamic>> groups = [
    {
      'name': 'Community Savings Group',
      'amountToPay': 1500.0,
      'totalYield': 18000.0,
      'interest': 12.0,
    },
    {
      'name': 'Neighborhood Chit Fund',
      'amountToPay': 2000.0,
      'totalYield': 24000.0,
      'interest': 10.0,
    },
    {
      'name': 'Women Empowerment Group',
      'amountToPay': 1000.0,
      'totalYield': 12000.0,
      'interest': 15.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self Help Groups'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group['name'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Amount to pay per month: ₹${group['amountToPay'].toStringAsFixed(2)}'),
                  Text('Total yield (with interest): ₹${group['totalYield'].toStringAsFixed(2)}'),
                  Text('Interest rate: ${group['interest']}%'),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelfHelpGroupScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004080),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Join Group', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
