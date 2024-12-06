import 'package:chat_app/core/resources/fcm_service.dart';
import 'package:chat_app/core/styles/color_manager.dart';
import 'package:chat_app/core/utils/bloc_observer.dart';
import 'package:chat_app/features/homeScreen/presentation/view/home_screen.dart';
import 'package:chat_app/features/introScreen/presentation/view/intro_screen.dart';
import 'package:chat_app/features/signInScreen/presentation/view/sign_in_Screen.dart';
import 'package:chat_app/features/signUpScreen/presentation/view/sign_up_Screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((e) async {
    // NotificationService notificationService = NotificationService();
    // await notificationService.registerNotification();
    // notificationService.configureLocalNotification();

    // FirebaseMessaging.onBackgroundMessage(firebaseMessegingBackgroundHandler);
  });

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "intro": (context) => const IntroScreen(),
        "signIn": (context) => SignInScreen(),
        "signUp": (context) => SignUpScreen(),
        "home": (context) => const HomeScreen(),
      },
      title: 'Chat App Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.secondary),
        useMaterial3: true,
      ),
      initialRoute: "intro",
    );
  }
}
