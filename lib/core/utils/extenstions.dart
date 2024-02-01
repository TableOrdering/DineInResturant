import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [StringExtensions] is a [extension] on [String] for validation.
extension StringExtensions on String {
  /// [isEmail] checks if the string is a valid email address.
  /// It returns true if the string is a valid email address.
  /// It returns false if the string is not a valid email address.

  bool isEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  /// [isMobileNumber] checks if the string is a valid mobile number.
  /// It returns true if the string is a valid mobile number.
  /// It returns false if the string is not a valid mobile number.
  bool isMobileNumber() {
    return RegExp(
      r'^[0-9]{10}$',
    ).hasMatch(this);
  }

  /// [isPasswordStrong] checks if the string is a valid password.
  bool isPasswordStrong() {
    return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#%()\$&*~]).{8,}$',
    ).hasMatch(this);
  }

  /// [toCapitalize] returns a capitalized string.
  /// It returns a capitalized string.
  String toCapitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}


/// [ColorExtensions] is list of [extension's] methods for [Color] class.
extension ColorExtensions on Color {
  /// This is used to convert [Color] to [MaterialColor] for [ThemeData].
  MaterialColor toMaterialColor() {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = red, g = green, b = blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }
}

/// [BuildContextExtensions] is list of [extension's] methods for [BuildContext] class.
/// [BuildContext] is a handle to the location of a widget in the widget tree.
extension BuildContextExtensions on BuildContext {
  /// [showMessage] is used to show a dialouge with a [message] & [title].
  void showMessage({
    required String title,
    required String message,
    void Function()? onPressed,
    String buttonText = '  Okay  ',
  }) =>
      showDialog(
        context: this,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: onPressed ?? () => context.pop(),
              child: Text(buttonText),
            )
          ],
        ),
      );
}


