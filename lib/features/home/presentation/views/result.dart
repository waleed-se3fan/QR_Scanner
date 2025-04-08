import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/common/widgets/custom_btn.dart';
import 'package:qr_scanner/features/home/presentation/bloc/qrcode_bloc.dart';
import 'package:qr_scanner/features/home/presentation/widgets/customItemcard.dart';
import 'package:qr_scanner/features/home/presentation/widgets/custom_header.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<QrcodeBloc>().add(GetScanResultEvent());
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<QrcodeBloc, QrcodeState>(
          builder: (context, state) {
            return Column(
              children: [
                const CustomHeader(isResult: true),
                const Text(
                  'Scanning Result',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Proreader will Keep your last 10 days history to keep your all scared history please purched our pro package.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                BlocBuilder<QrcodeBloc, QrcodeState>(
                  builder: (context, state) {
                    return Container(
                      height: 400,
                      padding: const EdgeInsets.all(20),
                      child: state is SuccesScanResultState
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.scanResult.length,
                              itemBuilder: (context, index) {
                                return CustomItemCard(state.scanResult, index);
                              })
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    );
                  },
                ),
                CustomButton(text: 'Send', onPressed: () {})
              ],
            );
          },
        ),
      ),
    );
  }
}
