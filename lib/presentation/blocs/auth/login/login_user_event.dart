part of 'login_user_bloc.dart';

abstract class LoginUserEvent extends Equatable {
  const LoginUserEvent();

  @override
  List<Object?> get props => [];
}

class LoginUserRequested extends LoginUserEvent {
  final String email;
  final String password;

  const LoginUserRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
