// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> registerNotification() async {
//     await _firebaseMessaging.requestPermission();

//     String? deviceToken = await _firebaseMessaging.getToken();
//     // save device token in cache

//     debugPrint('device token is : $deviceToken');

//     FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessege) {
//       showNotification(remoteMessege);
//     });
//   }

//   Future<void> showNotification(RemoteMessage remoteMessege) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         const AndroidNotificationDetails(
//             'testnotification', 'testnotificationchannel',
//             playSound: true,
//             enableVibration: true,
//             importance: Importance.max,
//             priority: Priority.high);
//     if (Platform.isAndroid) {
//       AndroidNotificationChannel channel = const AndroidNotificationChannel(
//           'testNotification', 'test NotificationChannel',
//           importance: Importance.max);

//       await _flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//     }

// //IOS
//     DarwinNotificationDetails darwinNotificationDetails =
//         const DarwinNotificationDetails(presentSound: true);

//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//         alert: true, sound: true, badge: true);

//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: darwinNotificationDetails);

// //Show Notification
//     _flutterLocalNotificationsPlugin.show(0, remoteMessege.notification?.title,
//         remoteMessege.notification?.body, notificationDetails,
//         payload: null);
//   }

//   Future<void> configureLocalNotification() async {
//     AndroidInitializationSettings androidInitializationSettings =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');

//     DarwinInitializationSettings darwinInitializationSettings =
//         const DarwinInitializationSettings(
//             requestAlertPermission: true,
//             requestBadgePermission: true,
//             requestSoundPermission: true);

//     InitializationSettings initializationSettings = InitializationSettings(
//         android: androidInitializationSettings,
//         iOS: darwinInitializationSettings);

//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
// }
