import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signup({required Function() onSuccess}) async {
    emit(LoadingState());
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      storeUserData(userCredential);
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

  Future<void> storeUserData(UserCredential userCredential) async {
    final user = userCredential.user;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'email': user.email,
      'uid': user.uid,

      // Add additional user data fields as needed
    }, SetOptions(merge: true));
  }
//// TODO: Store User Data in data base
//// TODO: Build Stream to Chat
}
