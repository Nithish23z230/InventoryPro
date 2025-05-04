import 'package:flutter/material.dart';
import 'dart:io';

import 'payment_method_selection_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller; // Commented out due to missing package
  String? scannedData;
  TextEditingController amountController = TextEditingController();

  // In order to get hot reload to work we need to pause the camera if the platform is android
  @override
  void reassemble() {
    super.reassemble();
    // if (Platform.isAndroid) {
    //   controller?.pauseCamera();
    // }
    // controller?.resumeCamera();
  }

  @override
  void dispose() {
    // controller?.dispose();
    amountController.dispose();
    super.dispose();
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     if (mounted) {
  //       setState(() {
  //         scannedData = scanData.code;
  //         controller.pauseCamera();
  //       });
  //     }
  //   });
  // }

  void _resetScanner() {
    setState(() {
      scannedData = null;
      amountController.clear();
      // controller?.resumeCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Scanner"),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: scannedData == null
          ? Center(
              child: Text(
                "QR Scanner functionality requires 'qr_code_scanner' package to be installed.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Scanned Payee Info:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    scannedData ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Enter Amount",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (scannedData != null && amountController.text.isNotEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PaymentMethodSelectionScreen(
                              payeeInfo: scannedData!,
                              amount: amountController.text,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please scan a QR code and enter an amount')),
                        );
                      }
                    },
                    child: Text("Proceed to Pay"),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: _resetScanner,
                    child: Text("Scan Again"),
                  ),
                ],
              ),
            ),
    );
  }
}
