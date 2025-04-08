part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;
  final GlobalKey<FormState> formkey;

  LoginButtonPressedEvent({
    required this.email,
    required this.password,
    required this.formkey,
  });
}
