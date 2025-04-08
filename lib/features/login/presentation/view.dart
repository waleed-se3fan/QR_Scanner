import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/common/functions/validator.dart';
import 'package:qr_scanner/core/common/widgets/custom_btn.dart';
import 'package:qr_scanner/core/common/widgets/custom_text_field.dart';
import 'package:qr_scanner/features/home/presentation/views/scan.dart';
import 'package:qr_scanner/features/login/presentation/bloc/login_bloc.dart';
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
                hintText: 'Enter your Email',
                validator: (value) => Validator.validateEmail(value),
              ),
              CustomTextField(
                controller: LoginBloc.passwordController,
                obscureText: true,
                hintText: 'Password',
                validator: (value) => Validator.validatePassword(value),
                isPassword: true,
              ),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 12),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(color: Color(0xff757575)),
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state is LoginLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          text: 'Login',
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                LoginButtonPressedEvent(
                                    email: LoginBloc.emailController.text,
                                    password: LoginBloc.passwordController.text,
                                    formkey: formKey));
                          });
                },
                listener: (BuildContext context, LoginState state) {
                  if (state is LoginSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login successful'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return QRCodeScannerScreen();
                    }));
                  } else if (state is LoginFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else
                    null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
