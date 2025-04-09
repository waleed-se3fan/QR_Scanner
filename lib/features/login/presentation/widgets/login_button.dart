import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/common/widgets/custom_btn.dart';
import 'package:qr_scanner/core/utils/app_colors.dart';
import 'package:qr_scanner/core/utils/app_strings.dart';
import 'package:qr_scanner/features/home/presentation/views/scan.dart';
import 'package:qr_scanner/features/login/presentation/bloc/login_bloc.dart';

class LoginBuutton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginBuutton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        return state is LoginLoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomButton(
                text: AppStrings.login,
                onPressed: () {
                  context.read<LoginBloc>().add(LoginButtonPressedEvent(
                      email: LoginBloc.emailController.text,
                      password: LoginBloc.passwordController.text,
                      formkey: formKey));
                });
      },
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.loginSuccess),
              backgroundColor: AppColors.successColor,
            ),
          );
          Navigator.push(context, MaterialPageRoute(builder: (c) {
            return const QRCodeScannerScreen();
          }));
        } else if (state is LoginFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: AppColors.errorColor,
            ),
          );
        } else
          null;
      },
    );
  }
}
