import 'package:awesome_dialog/awesome_dialog.dart';
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
      if (credential.user!.emailVerified) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        customDialog(
          context,
          errorMessage: "Please go to your mail to activate the account",
          title: "Warning",
          dialogType: DialogType.warning,
        );
      }

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
          errorMessage = 'Email or password is incorrect !';
          break;
      }
      print(errorMessage);
      emit(SignInErrorState(errorMessage));
    }
  }

  forgetPassword(BuildContext context) async {
    if (emailController.text == "") {
      customDialog(context,
          errorMessage: 'Please Enter Your Email',
          dialogType: DialogType.error,
          title: "Error");
      return;
    }

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      customDialog(
        context,
        errorMessage: "Please go to your mail to Reset the Password",
        dialogType: DialogType.success,
        title: "Reset Password",
      );
    } catch (e) {
      customDialog(
        context,
        errorMessage: "Please make sure you enter the correct email ",
        dialogType: DialogType.error,
        title: "Error",
      );
    }
  }
}
