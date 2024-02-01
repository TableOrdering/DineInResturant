import 'dart:convert';
import 'package:flutter/foundation.dart';

_parseAndDecode(String response) => jsonDecode(response);

parseJSON(String text) => compute(_parseAndDecode, text);
