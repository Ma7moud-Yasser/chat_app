import 'package:chat_app/core/components/custom_button.dart';
import 'package:chat_app/core/components/custome_text_form.dart';
import 'package:chat_app/core/styles/assets_manager.dart';
import 'package:chat_app/core/styles/color_manager.dart';
import 'package:chat_app/features/signUpScreen/presentation/controller/sginUp_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller/signUp_cubit.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: BlocProvider(
            create: (context) => SignUpCubit(),
            child: BlocConsumer<SignUpCubit, SignUpStates>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                final cubit = SignUpCubit.get(context);
                return Form(
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
                        controller: cubit.nameController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Please enter your user name';
                          }
                        },
                        title: "User Name",
                      ),
                      const SizedBox(height: 20),
                      CustomTextForm(
                        icon: Icons.email,
                        controller: cubit.emailController,
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
                        controller: cubit.passwordController,
                        validator: (p0) {
                          if (p0!.isEmpty || p0.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                        },
                        title: "Password",
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                          isLoading: state is SignUpLoadingState,
                          name: "Sign Up",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              cubit.signUp(context);
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
