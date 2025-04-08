import 'package:flutter/material.dart';
import 'package:qr_scanner/core/common/widgets/custom_btn.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text(
              "Scanning Result",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Proreader will Keep your last 10 days history to keep your all scared history please purched our pro package.",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          CustomButton(text: 'Send', onPressed: () {})
        ],
      ),
    );
  }
}
