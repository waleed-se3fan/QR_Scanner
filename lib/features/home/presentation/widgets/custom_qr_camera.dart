import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/core/utils/app_colors.dart';
import 'package:qr_scanner/core/utils/app_strings.dart';
import 'package:qr_scanner/features/home/presentation/bloc/qrcode_bloc.dart';

class CustomQrCamera extends StatelessWidget {
  const CustomQrCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrcodeBloc, QrcodeState>(
      builder: (context, state) {
        return Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      width: 200.w,
                      height: 200.h,
                      child: QRView(
                        key: context.read<QrcodeBloc>().qrKey,
                        onQRViewCreated: (control) {
                          context
                              .read<QrcodeBloc>()
                              .add(QRViewCreatedEvent(control));
                        },
                        overlay: QrScannerOverlayShape(
                          borderColor: Colors.orange,
                          borderRadius: 10,
                          borderLength: 30,
                          borderWidth: 10,
                          cutOutSize: 200,
                        ),
                      )),
                  Container(
                    width: 180.w,
                    height: 2.h,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            const Text(
              AppStrings.codeScanning,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
