import 'dart:async';
import 'dart:developer';
import 'package:dine_in/core/debug/app_bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
  }

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

  /// if device is mobile then set orientation to portrait. and can't rotate and change orientation.
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
  }

  /// user bloc observer to observe the state changes in the blocs and cubits
  Bloc.observer = AppBlocObserver();

  final app = await builder();
  runApp(app);
}
