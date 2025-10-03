part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

 class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}


class AuthloadingState  extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AuthfailuireState  extends AuthState {
  String error;
  AuthfailuireState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
class AuthSuccessState  extends AuthState {

  AuthSuccessState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}