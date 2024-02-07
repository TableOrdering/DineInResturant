import 'dart:async';
import 'dart:developer';
import 'package:dine_in/core/debug/app_bloc_observer.dart';
import 'package:dine_in/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// [startApplication] is the entry point of the application.
/// It creates the [MaterialApp] and starts the [runApp] function.
/// It also adds the [AppBlocObserver] to debug.
/// It is used to debug the application.
Future<void> startApplication(FutureOr<Widget> Function() builder) async {
  /// insureInitialization is used to insure that the initialization of the application is done.
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
  }

  /// [Firebase] is service that provides the backend services for the application.
  /// [initializeApp] is used to initialize the firebase app.
  /// [DefaultFirebaseOptions] is used to initialize the firebase app with the default options.
  /// [currentPlatform] is platform that the application is running on.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// firebase messaging for background
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  await messaging.requestPermission(sound: true);
  // await Permission.accessNotificationPolicy.request();
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  /// [FlutterError.onError] are used to handle errors.
  FlutterError.onError =
      (details) => log(details.exceptionAsString(), stackTrace: details.stack);

  /// [AppBlocObserver] is used to debug the application.
  Bloc.observer = AppBlocObserver();

  /// [HydratedBloc.storage] is used to store the data of the application.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  final _ = await builder();
  return runApp(_);
}