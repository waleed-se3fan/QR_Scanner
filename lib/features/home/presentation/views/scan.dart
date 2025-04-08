import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/common/widgets/custom_btn.dart';
import 'package:qr_scanner/features/home/presentation/bloc/qrcode_bloc.dart';
import 'package:qr_scanner/features/home/presentation/widgets/custom_header.dart';
import 'package:qr_scanner/features/home/presentation/widgets/custom_qr_camera.dart';
import 'package:qr_scanner/features/home/presentation/widgets/row_of_actions.dart';

class QRCodeScannerScreen extends StatelessWidget {
  const QRCodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<QrcodeBloc, QrcodeState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    const CustomHeader(
                      isResult: false,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Scan OR code',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text(
                        'Place qr code inside the frame to scan please avoid shake to get results quickly',
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
                        text: 'Place Camera Code',
                        onPressed: () {
                          context.read<QrcodeBloc>().controller!.resumeCamera();
                        }),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
