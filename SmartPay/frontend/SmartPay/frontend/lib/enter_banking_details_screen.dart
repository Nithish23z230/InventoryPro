import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import your Login screen

class EnterBankingDetailsScreen extends StatefulWidget {
  const EnterBankingDetailsScreen({super.key});

  @override
  State<EnterBankingDetailsScreen> createState() =>
      _EnterBankingDetailsScreenState();
}

class _EnterBankingDetailsScreenState extends State<EnterBankingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  final _ifscController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountHolderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text(
          'Bank Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildInputField(
                    controller: _accountHolderController,
                    icon: Icons.person,
                    label: 'Account Holder Name',
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: _accountNumberController,
                    icon: Icons.credit_card,
                    label: 'Account Number',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: _ifscController,
                    icon: Icons.code,
                    label: 'IFSC Code',
                    textCapitalization: TextCapitalization.characters,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    controller: _bankNameController,
                    icon: Icons.account_balance,
                    label: 'Bank Name',
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Banking details submitted')),
                        );
                      }
                    },
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Skip button to go back to login screen
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      controller: controller,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF1E3A8A)),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 2),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }
}
