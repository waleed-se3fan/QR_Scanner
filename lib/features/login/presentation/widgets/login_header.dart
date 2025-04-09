import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_scanner/core/utils/app_colors.dart';
import 'package:qr_scanner/core/utils/app_strings.dart';
import 'package:qr_scanner/features/login/presentation/widgets/orange_circle.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.w,
      width: double.infinity,
      child: Stack(
        children: [
          const OrangeCircle(left: -30, top: -60, size: 330),
          const OrangeCircle(right: -80, top: -10, size: 250),
          Positioned(
            top: 130.h,
            left: 150.w,
            child: const Text(
              AppStrings.login,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
