part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class CheckButtonPressed extends RegisterEvent {
  final String username;
  final String email;
  final String password;

  const CheckButtonPressed(
      {required this.username, required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterButtonPressed extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String division;

  const RegisterButtonPressed(
      {required this.username,
      required this.email,
      required this.password,
      required this.division});

  @override
  List<Object?> get props => [username, email, password, division];
}

class ClearRegisterData extends RegisterEvent {
  const ClearRegisterData();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordButtonPressed extends RegisterEvent {
  final String email;

  const ForgotPasswordButtonPressed({required this.email});

  @override
  List<Object?> get props => [email];
}
