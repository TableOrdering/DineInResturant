import 'package:flutter/material.dart';

/// list of all devices
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// breakpoints for mobile, tablet and desktop
const mobile = 320.0;
const tablet = 600.0;
const desktop = 960.0;

DeviceType _displayTypeOf(BuildContext context) {
  /// use shortest width to detect device type regardless of orientation.
  double deviceWidth = MediaQuery.of(context).size.width;
  if (deviceWidth >= desktop) {
    return DeviceType.desktop;
  } else if (deviceWidth >= tablet) {
    return DeviceType.tablet;
  } else {
    return DeviceType.mobile;
  }
}

bool isDeviceMobile(BuildContext context) =>
    _displayTypeOf(context) == DeviceType.mobile;

bool isDeviceTablet(BuildContext context) =>
    _displayTypeOf(context) == DeviceType.tablet;

bool isDeviceDesktop(BuildContext context) =>
    _displayTypeOf(context) == DeviceType.desktop;

/// [Utils] this class code is used for Global use.
class Utils {
  static double kMobileMaxWidth =
      600.0; // Define the maximum width threshold for mobile devices

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
