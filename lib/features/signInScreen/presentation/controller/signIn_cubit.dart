import 'package:chat_app/features/signInScreen/presentation/controller/signIn_States.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_dialog.dart';

class SignInScreenCubit extends Cubit<SignInStates> {
  SignInScreenCubit() : super(SignInInitialStates());
  static SignInScreenCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn(BuildContext context) async {
    emit(SignInLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, 'home');
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        default:
          errorMessage = ' ${e.message}';
          break;
      }
      emit(SignInErrorState(errorMessage));
      print(errorMessage);

      customDialog(
        context,
        errorMessage: errorMessage,
        isError: true,
      );
    }
  }
}
