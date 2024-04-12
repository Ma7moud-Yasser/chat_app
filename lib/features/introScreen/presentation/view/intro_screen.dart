import 'package:chat_app/core/components/custom_button.dart';
import 'package:chat_app/core/styles/assets_manager.dart';
import 'package:chat_app/core/styles/color_manager.dart';
import 'package:chat_app/features/homeScreen/presentation/view/home_screen.dart';
import 'package:chat_app/features/signInScreen/presentation/view/sign_in_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: Stack(
        children: [
          SvgPicture.asset(
            ImageAssets.background,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 100),
                    child: SvgPicture.asset(ImageAssets.logo),
                  ),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [
                          ColorManager.white,
                          ColorManager.primary,
                        ],
                        tileMode: TileMode.repeated,
                      ).createShader(bounds);
                    },
                    child: const Text(
                      "Welcome To \nThe Stars Clan Chat ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    isLoading: false,
                    name: "Continue",
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FirebaseAuth.instance.currentUser == null
                                    ? SignInScreen()
                                    : const HomeScreen(),
                          ),
                          (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0, .9),
            child: Text("Connect With Your Clan's Members Here!",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.white,
                )),
          )
        ],
      ),
    );
  }
}
