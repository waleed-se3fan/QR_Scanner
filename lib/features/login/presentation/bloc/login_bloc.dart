// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qr_scanner/features/login/data/datasource/remote_data_source.dart';
import 'package:qr_scanner/features/login/data/repositories/login_impl.dart';
import 'package:qr_scanner/features/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) {});
    on<LoginButtonPressedEvent>(
      (event, emit) {
        signIn(
            email: event.email,
            password: event.password,
            formkey: event.formkey);
      },
    );
  }
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  final usecase = LoginUseCase(LoginRepositoryIml(LoginRemoteDataSourceImpl()));
  signIn(
      {required String email,
      required String password,
      required formkey}) async {
    emit(LoginLoadingState());

    if (formkey.currentState!.validate()) {
      final result = await usecase.call(email, password);
      result.fold((failure) => emit(LoginFailureState(error: failure.message)),
          (user) => emit(LoginSuccessState(message: 'Login successful')));
      print(state);
    } else {
      emit(LoginFailureState(error: 'Please fill all fields'));
    }
  }
}
