part of 'login_user_bloc.dart';

abstract class LoginUserState extends Equatable {
  const LoginUserState();

  @override
  List<Object?> get props => [];
}

class LoginUserInitial extends LoginUserState {}

class LoginUserLoading extends LoginUserState {}

class LoginUserSuccess extends LoginUserState {
  final dynamic response;

  const LoginUserSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LoginUserNoInternet extends LoginUserState {}

class LoginUserFailure extends LoginUserState {
  final String message;

  const LoginUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}