import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/core/components/custom_dialog.dart';
import 'package:chat_app/features/signUpScreen/presentation/controller/sginUp_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitState());
  static SignUpCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController image = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    emit(SignUpLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      credential.user!.sendEmailVerification();
      Navigator.pushReplacementNamed(context, 'signIn');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        customDialog(
          context,
          errorMessage: 'The password provided is too weak.',
          title: "Error",
          dialogType: DialogType.error,
        );
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        customDialog(
          context,
          errorMessage: 'The account already exists for that email.',
          title: "Error",
          dialogType: DialogType.error,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
