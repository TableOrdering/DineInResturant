// import 'dart:async';
// import 'dart:developer';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// /// [startApplication] is the entry point of the application.
// /// It creates the [MaterialApp] and starts the [runApp] function.
// /// It also adds the [AppBlocObserver] to debug.
// /// It is used to debug the application.
// Future<void> startApplication(FutureOr<Widget> Function() builder) async {
//   /// insureInitialization is used to insure that the initialization of the application is done.
//   WidgetsFlutterBinding.ensureInitialized();

//   if (!kIsWeb &&
//       (defaultTargetPlatform == TargetPlatform.android ||
//           defaultTargetPlatform == TargetPlatform.iOS)) {
//     await SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
//     );
//   }

//   /// [Firebase] is service that provides the backend services for the application.
//   /// [initializeApp] is used to initialize the firebase app.
//   /// [DefaultFirebaseOptions] is used to initialize the firebase app with the default options.
//   /// [currentPlatform] is platform that the application is running on.
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   /// firebase messaging for background
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   final messaging = FirebaseMessaging.instance;
//   await messaging.requestPermission();
//   await messaging.requestPermission(sound: true);
//   await Permission.accessNotificationPolicy.request();
//   await messaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   /// [FlutterError.onError] are used to handle errors.
//   FlutterError.onError =
//       (details) => log(details.exceptionAsString(), stackTrace: details.stack);

//   /// [AppBlocObserver] is used to debug the application.
//   Bloc.observer = AppBlocObserver();

//   /// [HydratedBloc.storage] is used to store the data of the application.
//   HydratedBloc.storage = await HydratedStorage.build(
//     storageDirectory: kIsWeb
//         ? HydratedStorage.webStorageDirectory
//         : await getApplicationDocumentsDirectory(),
//   );

//   final _ = await builder();
//   return runApp(_);
// }

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// /// [displayNotification] is used to display the notification.
// Future<void> displayNotification(RemoteMessage message) async {
//   log('displayNotification ${message.toMap()}', name: 'displayNotification');

//   try {
//     const initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     AndroidNotificationDetails androidNotificationDetails;
//     print("ChannelIUD : ${message.notification?.android?.channelId}");
//     /// TODO for the ["tingting-store"] create raw folder then place the mp3
//     if (message.notification?.android?.channelId == "tingting-store") {
//       print("ChannelIUD : ${message.notification?.android?.channelId}");
//       print("ChannelIUD : 1");
//       androidNotificationDetails = const AndroidNotificationDetails(
//         'tingting-store',
//         'TingTing-Store',
//         channelDescription: 'TingTing Store Notification Channel Description',
//         importance: Importance.max,
//         priority: Priority.max,
//         playSound: true,
//         ongoing: true,
//         enableLights: true,
//         styleInformation: BigTextStyleInformation(
//           'Ting-Ting Store Notification',
//         ),
//       );
//     } else {
//       print("ChannelIUD : ${message.notification?.android?.channelId}");
//       print("ChannelIUD : 2");
//       androidNotificationDetails = const AndroidNotificationDetails(
//         'tingting-store1',
//         'TingTing-Store',
//         channelDescription: 'TingTing Store Notification Channel Description',
//         importance: Importance.max,
//         priority: Priority.max,
//         playSound: true,
//         ongoing: true,
//         enableLights: true,
//         sound: RawResourceAndroidNotificationSound('taco_bell'),
//         styleInformation: BigTextStyleInformation(
//           'Ting-Ting Store Notification',
//         ),
//       );
//     }

//     const iOSNotificationDetails = DarwinNotificationDetails();
//     const macOSNotificationDetails = DarwinNotificationDetails();
//     final details = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: iOSNotificationDetails,
//       macOS: macOSNotificationDetails,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title,
//       message.notification?.body,
//       details,
//     );
//   } on Exception catch (_) {
//     throw Exception('Notification Display Error Occurred!');
//   }
// }

// // [_firebaseMessagingBackgroundHandler] is a top-level function that's
// /// called when the app is in the background or terminated.
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     displayNotification(message);
//   } on Exception catch (_) {
//     throw Exception('Firebase Initialization Error Occured!');
//   }
// }
