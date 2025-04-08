import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
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
                      width: 200,
                      height: 200,
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
                    width: 180,
                    height: 2,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Scanning Code...",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
