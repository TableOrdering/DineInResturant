import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final StreamController<RemoteMessage> controller =
      StreamController<RemoteMessage>.broadcast();

  void init() {
    requestPermission().then(
      (status) {
        forgroundNotification(); // forground notification
        backgroundNotification(); // background notification
        terminateNotification(); // terminate notification
      },
    );
  }

  /// request permission for ios and android
  Future<bool> requestPermission() async {
    try {
      final messaging = FirebaseMessaging.instance;
      debugPrint('Notification : Checking Supported!');

      if (!(await messaging.isSupported())) return false;
      debugPrint('Notification : Supported Checked confiming Permission!');
      final permission = await messaging.requestPermission();
      debugPrint('Notification : Permission Requested!');

      /// setting up firebase messaging mainly for receiving notification in foreground ios
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      if (permission.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('Notification : Permission Granted!');
        return true;
      } else if (permission.authorizationStatus ==
          AuthorizationStatus.provisional) {
        debugPrint('Notification : Provisional Permission Granted!');
        return true;
      } else if (permission.authorizationStatus ==
          AuthorizationStatus.notDetermined) {
        debugPrint('Notification : Permission Not Granted!');
        await messaging.requestPermission();
        return false;
      }
      return false;
    } on Exception catch (_) {
      throw Exception('Notification : Error Occured!');
    }
  }

  void forgroundNotification() {
    FirebaseMessaging.onMessage.listen(
      (message) async {
        if (message.notification != null) {
          controller.add(message);
        }
      },
      onError: (error) {
        controller.addError(error);
      },
    );
  }

  void backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        if (message.notification != null) {
          controller.add(message);
        }
      },
      onError: (error) {
        controller.addError(error);
      },
    );
  }

  void terminateNotification() async {
    try {
      RemoteMessage? message =
          await FirebaseMessaging.instance.getInitialMessage();
      if (message != null) {
        if (message.notification != null) {
          controller.add(message);
        }
      }
    } on Exception catch (e) {
      controller.addError(e);
    }
  }
}
