import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_scanner/core/common/widgets/custom_btn.dart';
import 'package:qr_scanner/core/utils/app_strings.dart';
import 'package:qr_scanner/features/home/presentation/bloc/qrcode_bloc.dart';
import 'package:qr_scanner/features/home/presentation/widgets/custom_header.dart';
import 'package:qr_scanner/features/home/presentation/widgets/custom_qr_camera.dart';
import 'package:qr_scanner/features/home/presentation/widgets/row_of_actions.dart';

class QRCodeScannerScreen extends StatelessWidget {
  const QRCodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<QrcodeBloc, QrcodeState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 120.h,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const CustomHeader(
                        isResult: false,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        AppStrings.scan,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Text(
                          AppStrings.scanDescription2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const CustomQrCamera(),
                      const SizedBox(height: 20),
                      const CustomActionsRow(),
                      CustomButton(
                          text: AppStrings.placeCamera,
                          onPressed: () {
                            context
                                .read<QrcodeBloc>()
                                .controller!
                                .resumeCamera();
                          }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
