import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg) => Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.black,
      fontSize: 14,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      timeInSecForIosWeb: 2,
      webBgColor: "#000000",
    );
