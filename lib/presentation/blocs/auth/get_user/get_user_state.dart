
part of 'get_user_bloc.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object?> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserSuccess extends GetUserState {
  final dynamic user;

  const GetUserSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class GetUserFailure extends GetUserState {
  final String message;

  const GetUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}
