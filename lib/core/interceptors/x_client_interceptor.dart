import 'package:dine_in_resturant/core/env/environment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

/// import convert to convert the map to json.
import 'dart:convert' as convert;

/// [XClientInterceptor] is a interceptor for [Client] to add [X-Client-Headers] to the request.
/// [XClientInterceptor] is used to add the [X-Client-Headers] to the request
/// [X-Client-Headers] is a custom header that is used to identify the client.

class XClientInterceptor extends Interceptor {
  /// [XClientInterceptor] constructor.
  /// [XClientInterceptor] requires the [client] to be passed.
  XClientInterceptor();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var xClientHeaders = <String, dynamic>{
      'x-client-version': '1.0.0',
      'x-build-number': kMinimumBuildNumber,
    };

    // print('\x1B[32m defaultTargetPlatform: $defaultTargetPlatform \x1B[0m');

    if (defaultTargetPlatform == TargetPlatform.android) {
      xClientHeaders['x-client-platform'] = 'android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      xClientHeaders['x-client-platform'] = 'ios';
    } else if (kIsWeb) {
      xClientHeaders['x-client-platform'] = 'web';
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      xClientHeaders['x-client-platform'] = 'windows';
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      xClientHeaders['x-client-platform'] = 'macos';
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      xClientHeaders['x-client-platform'] = 'linux';
    } else if (defaultTargetPlatform == TargetPlatform.fuchsia) {
      xClientHeaders['x-client-platform'] = 'fuchsia';
    } else {
      xClientHeaders['x-client-platform'] = 'unknown';
    }

    /// platform is platform of the client.
    /// version is version of the client.
    options.headers = {
      ...options.headers,
      'x-client-headers': convert.jsonEncode(xClientHeaders),
    };
    // print('\x1B[32m xClientHeaders: $xClientHeaders \x1B[0m');
    return handler.next(options);
  }
}
