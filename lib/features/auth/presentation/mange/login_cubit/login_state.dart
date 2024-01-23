part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class AuthenticatedState extends LoginState {
  final UserCredential userCredential;

  AuthenticatedState(this.userCredential);
}

class UnauthenticatedState extends LoginState {
  final String errorMsg;

  UnauthenticatedState(this.errorMsg);
}
