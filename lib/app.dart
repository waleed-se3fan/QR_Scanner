import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/features/home/presentation/bloc/qrcode_bloc.dart';
import 'package:qr_scanner/features/home/presentation/views/scan.dart';
import 'package:qr_scanner/features/login/presentation/bloc/login_bloc.dart';
import 'package:qr_scanner/features/login/presentation/view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<QrcodeBloc>(
          create: (context) => QrcodeBloc()..add(RequestPermissionEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: QRCodeScannerScreen(),
      ),
    );
  }
}
