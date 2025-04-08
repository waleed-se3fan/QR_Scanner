import 'package:flutter/material.dart';

class OrangeCircle extends StatelessWidget {
  final double size;
  final double? left;
  final double? right;
  final double top;

  const OrangeCircle({
    super.key,
    required this.size,
    this.left,
    this.right,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.orangeAccent.withOpacity(0.3),
        ),
      ),
    );
  }
}
