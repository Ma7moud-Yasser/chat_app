import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/core/components/custom_button.dart';
import 'package:chat_app/core/components/custom_dialog.dart';
import 'package:chat_app/core/components/custom_text_form.dart';
import 'package:chat_app/core/styles/assets_manager.dart';
import 'package:chat_app/core/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controller/signIn_States.dart';
import '../controller/signIn_cubit.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: BlocProvider(
            create: (context) => SignInScreenCubit(),
            child: BlocConsumer<SignInScreenCubit, SignInStates>(
              listener: (context, state) {
                if (state is SignInErrorState) {
                  customDialog(
                    context,
                    errorMessage: state.msg,
                    title: "Error",
                    dialogType: DialogType.error,
                  );
                }
              },
              builder: (context, state) {
                final cubit = SignInScreenCubit.get(context);
                return Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.1,
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
                        icon: Icons.email,
                        controller: cubit.emailController,
                        validator: (p0) {
                          if (cubit.emailController.text == "") {
                            return 'Please Enter A Valid Email';
                          }
                        },
                        title: "Email",
                      ),
                      const SizedBox(height: 20),
                      CustomTextForm(
                        icon: Icons.password,
                        controller: cubit.passwordController,
                        validator: (p0) {
                          if (cubit.passwordController.text == "" ||
                              cubit.passwordController.text.isEmpty) {
                            return 'Please Enter A Correct Password';
                          }
                        },
                        title: "Password",
                      ),
                      Align(
                        alignment: const Alignment(1, 0),
                        child: TextButton(
                            onPressed: () {
                              cubit.forgetPassword(context);
                            },
                            child: const Text(
                              "Forget password ?",
                              style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                          isLoading: State is SignInLoadingState,
                          name: "Login",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              cubit.signIn(context);
                            }
                          }),
                      Row(
                        children: [
                          const Text(
                            "don't have an Account ?",
                            style: TextStyle(
                              color: ColorManager.gray,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  'signUp',
                                );
                              },
                              child: const Text(
                                "Sign Up",
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
