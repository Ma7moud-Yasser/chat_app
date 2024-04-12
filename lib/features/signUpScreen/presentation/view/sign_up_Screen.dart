import 'package:chat_app/core/components/custom_button.dart';
import 'package:chat_app/core/components/custom_dialog.dart';
import 'package:chat_app/core/components/custome_text_form.dart';
import 'package:chat_app/core/styles/assets_manager.dart';
import 'package:chat_app/core/styles/color_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 55,
                    child: SvgPicture.asset(
                      ImageAssets.logo,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextForm(
                  icon: Icons.person,
                  controller: userNameController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Please enter your user name';
                    }
                    return '';
                  },
                  title: "User Name",
                ),
                const SizedBox(height: 20),
                CustomTextForm(
                  icon: Icons.email,
                  controller: emailController,
                  validator: (p0) {
                    if (p0!.isEmpty || !p0.contains('@')) {
                      return 'Password must be at least 6 characters long';
                    }
                  },
                  title: "Email",
                ),
                const SizedBox(height: 20),
                CustomTextForm(
                  icon: Icons.password,
                  controller: passwordController,
                  validator: (p0) {
                    if (p0!.isEmpty || p0.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return '';
                  },
                  title: "Password",
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                    isLoading: false,
                    name: "Sign Up",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          Navigator.pushReplacementNamed(context, 'home');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            debugPrint('The password provided is too weak.');
                            customDialog(
                              context,
                              errorMessage:
                                  'The password provided is too weak.',
                              isError: true,
                            );
                          } else if (e.code == 'email-already-in-use') {
                            debugPrint(
                                'The account already exists for that email.');
                            customDialog(
                              context,
                              errorMessage:
                                  'The account already exists for that email.',
                              isError: true,
                            );
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    }),
                Row(
                  children: [
                    const Text(
                      "already have an Account ?",
                      style: TextStyle(
                        color: ColorManager.gray,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: 16,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
