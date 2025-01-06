part of 'register_user_bloc.dart';

abstract class RegisterUserState extends Equatable {
  const RegisterUserState();

  @override
  List<Object?> get props => [];
}

class RegisterUserInitial extends RegisterUserState {}

class RegisterUserLoading extends RegisterUserState {}

class RegisterUserSuccess extends RegisterUserState {
  final dynamic response;

  const RegisterUserSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class RegisterUserFailure extends RegisterUserState {
  final String message;

  const RegisterUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}
