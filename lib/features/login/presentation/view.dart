import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_scanner/core/common/functions/validator.dart';
import 'package:qr_scanner/core/common/widgets/custom_text_field.dart';
import 'package:qr_scanner/core/utils/app_strings.dart';
import 'package:qr_scanner/features/login/presentation/bloc/login_bloc.dart';
import 'package:qr_scanner/features/login/presentation/widgets/login_button.dart';
import 'package:qr_scanner/features/login/presentation/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const LoginHeader(),
              CustomTextField(
                controller: LoginBloc.emailController,
                hintText: AppStrings.email,
                validator: (value) => Validator.validateEmail(value),
              ),
              CustomTextField(
                controller: LoginBloc.passwordController,
                obscureText: true,
                hintText: AppStrings.password,
                validator: (value) => Validator.validatePassword(value),
                isPassword: true,
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 12.w),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      AppStrings.forgetPassword,
                      style: TextStyle(color: Color(0xff757575)),
                    )),
              ),
              SizedBox(
                height: 25.h,
              ),
              LoginBuutton(
                formKey: formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
