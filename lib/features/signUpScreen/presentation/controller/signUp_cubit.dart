import 'package:chat_app/core/models/user_model.dart';
import 'package:chat_app/features/signUpScreen/presentation/controller/sginUp_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreenCubit extends Cubit<SignUpScreenStates> {
  SignUpScreenCubit() : super(SignUpScreenInitState());
  static SignUpScreenCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController image = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    emit(SignUpScreenLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(SignUpScreenSuccessState());
      Navigator.pushReplacementNamed(context, 'home');
      //     .then((value) async {
      //   CollectionReference users =
      //       FirebaseFirestore.instance.collection('users');
      //   await users.doc(value.user!.uid).set({
      //     "name": nameController.text,
      //     "email": emailController.text,
      //     "password": passwordController.text,
      //   }).then((value) {
      //     emit(SignUpScreenSuccessState());
      //     Navigator.pushReplacementNamed(context, 'home');
      //   });
      // });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
