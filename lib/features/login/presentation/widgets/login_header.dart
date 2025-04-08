import 'package:flutter/material.dart';
import 'package:qr_scanner/features/login/presentation/widgets/orange_circle.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          OrangeCircle(left: -30, top: -60, size: 330),
          OrangeCircle(right: -80, top: -10, size: 250),
          Positioned(
            top: 130,
            left: 150,
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
