part of 'signup_cubit.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class LoadingState extends SignupState {}

class AuthenticatedState extends SignupState {
  final UserCredential userCredential;

  AuthenticatedState(this.userCredential);
}

class UnauthenticatedState extends SignupState {
  final String errorMsg;

  UnauthenticatedState(this.errorMsg);
}
