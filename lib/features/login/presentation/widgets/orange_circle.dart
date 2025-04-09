import 'package:flutter/material.dart';
import 'package:qr_scanner/core/utils/app_colors.dart';

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
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.circleColor,
        ),
      ),
    );
  }
}
