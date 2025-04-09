import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_scanner/core/utils/app_colors.dart';

class CustomItemCard extends StatelessWidget {
  final List scanResult;
  final int index;
  const CustomItemCard(this.scanResult, this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.description,
                color: AppColors.primaryColor,
                size: 24.0,
              ),
            ),
            SizedBox(width: 16.0.w),
            SizedBox(
              width: 220.w,
              child: Text(
                scanResult[index],
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
