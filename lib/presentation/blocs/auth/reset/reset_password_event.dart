part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordButtonPressed extends ResetPasswordEvent {
  final String email;

  const ResetPasswordButtonPressed({required this.email});

  @override
  List<Object> get props => [email];
}
