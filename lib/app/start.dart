import 'dart:async';
import 'dart:developer';
import 'package:dine_in_resturant/core/debug/app_bloc_observer.dart';
import 'package:dine_in_resturant/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

/// [startApplication] is the entry point of the application.
/// It is called from the main function.
/// It is responsible for starting the application and binding the application
/// to the device.
/// it accepts builder function as a parameter which returns the root widget
/// of the application.

Future<void> startApplication(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  // final token = await messaging.getToken();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // debugPrint('token: $token');

  /// request permission
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  /// [FlutterError.onError] are used to handle errors.
  FlutterError.onError = (details) async {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
      time: DateTime.now(),
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    log(
      error.toString(),
      stackTrace: stack,
      time: DateTime.now(),
    );
    return true;
  };

  /// initialize the application HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  /// user bloc observer to observe the state changes in the blocs and cubits
  Bloc.observer = AppBlocObserver();

  final app = await builder();
  runApp(app);
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// [displayNotification] is used to display the notification.
Future<void> displayNotification(RemoteMessage message) async {
  log('displayNotification ${message.toMap()}', name: 'displayNotification');

  try {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    AndroidNotificationDetails androidNotificationDetails;

    androidNotificationDetails = const AndroidNotificationDetails(
      'com.dinIn.dine_in_resturant',
      'com.dinIn.dine_in_resturant',
      channelDescription: 'Dine In Resturant Notification Channel Description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ongoing: true,
      enableLights: true,
      styleInformation: BigTextStyleInformation(
        'Dine In Resturant Notification',
      ),
    );

    const iOSNotificationDetails = DarwinNotificationDetails();
    const macOSNotificationDetails = DarwinNotificationDetails();
    final details = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
      macOS: macOSNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      details,
    );
  } on Exception catch (_) {
    throw Exception('Notification Display Error Occurred!');
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    displayNotification(message);
  } on Exception catch (_) {
    throw Exception('Firebase Initialization Error Occured!');
  }
}
