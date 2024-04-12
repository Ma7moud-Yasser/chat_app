import 'package:chat_app/core/components/custom_button.dart';
import 'package:chat_app/core/styles/assets_manager.dart';
import 'package:chat_app/core/styles/color_manager.dart';
import 'package:chat_app/features/signInScreen/presentation/view/sign_in_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        automaticallyImplyLeading: false,
        title: Text(
          "Chat",
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'signIn',
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout_sharp))
        ],
      ),
    );
  }
}
