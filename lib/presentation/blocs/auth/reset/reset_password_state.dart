part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  final String? message;
  final bool isLoading;
  final bool? data;

  const ResetPasswordState({this.message, this.isLoading = false, this.data});

  @override
  List<Object?> get props => [message, isLoading];
}

class ResetPasswordSuccess extends ResetPasswordState {
  final String email;

  const ResetPasswordSuccess({
    required this.email,
    super.message,
    super.isLoading,
  });

  @override
  List<Object?> get props => [email, message, isLoading];
}

class ResetPasswordFailed extends ResetPasswordState {
  const ResetPasswordFailed({super.message, super.isLoading});

  @override
  List<Object?> get props => [message, isLoading];
}
