part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String message;

  LoginSuccessState({required this.message});
}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState({required this.error});
}
