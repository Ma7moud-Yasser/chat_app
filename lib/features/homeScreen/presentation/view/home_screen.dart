import 'package:chat_app/core/styles/color_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        automaticallyImplyLeading: false,
        title: const Text(
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
