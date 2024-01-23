import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login({required Function() onSuccess}) async {
    emit(LoadingState());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(AuthenticatedState(userCredential));
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(UnauthenticatedState("The password provided is too weak"));
      } else if (e.code == 'email-already-in-use') {
        emit(UnauthenticatedState('The account already exists for that email'));
      } else {
        emit(UnauthenticatedState("Check Your Password"));
      }
    } catch (e) {
      emit(UnauthenticatedState(e.toString()));
    }
  }
}
