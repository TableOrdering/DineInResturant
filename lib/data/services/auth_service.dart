import 'dart:developer';
import 'package:dine_in_resturant/core/interceptors/x_client_interceptor.dart';
import 'package:dine_in_resturant/core/utils/constants.dart';
import 'package:dine_in_resturant/core/utils/helpers.dart';
import 'package:dine_in_resturant/data/model/json_response.dart';
import 'package:dine_in_resturant/data/model/operator.dart';
import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// [AuthService] is a class that handles all the authentication related
/// operations.
class AuthService {
  /// constructor and assigning the [dio] instance with the base url and options
  /// for the api.
  AuthService({required this.dio}) {
    dio.options.baseUrl = '$kURL$operatorPath';
    dio.options.sendTimeout = const Duration(minutes: 1);
    dio.options.receiveTimeout = const Duration(minutes: 1);
    dio.options.connectTimeout = const Duration(minutes: 1);
    dio.options.responseType = ResponseType.json;

    ///[LogInterceptor] is a interceptor that logs the request and response.
    ///It is used for debugging purpose.
    ///It is not used in production.
    dio.interceptors.add(LogInterceptor(
      logPrint: (obj) => log(obj.toString(), name: 'Authentication'),
    ));

    (dio.transformer as BackgroundTransformer).jsonDecodeCallback = parseJSON;
    dio.options.headers['Access-Control-Allow-Origin'] = '*';
    dio.options.headers['Access-Control-Allow-Methods'] =
        'GET,PUT,POST,DELETE,PATCH,OPTIONS';
    dio.options.headers['Access-Control-Allow-Headers'] =
        'Origin, X-Requested-With, Content-Type, Accept, Authorization';
    dio.options.headers['Access-Control-Allow-Credentials'] = 'true';
    dio.options.headers['Access-Control-Max-Age'] = '86400';

    /// [RetryOnConnectionChangeInterceptor] is a interceptor that retries the
    /// request if the connection is changed.
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      request: true,
    ));
    dio.interceptors.add(XClientInterceptor());
  }

  /// [dio] is the [Dio] instance used to make all the requests.
  /// [dio] is required to make all the requests.
  final Dio dio;

  /// [logIn] is a method that handles the sign in operation.
  /// [email] is the email of the admin.
  /// [password] is the password of the admin.
  /// [logIn] returns a [Future] of [JsonResponse].
  Future<JsonResponse> logIn({
    required String phone,
    required String password,
  }) async {
    try {
      final data = <String, dynamic>{'contact': phone, 'password': password};
      if (!kIsWeb) {
        final deviceToken = await FirebaseMessaging.instance.getToken();
        if (deviceToken != null) {
          data['deviceToken'] = deviceToken;
        }
      }

      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final info = await deviceInfoPlugin.deviceInfo;

      if (info is AndroidDeviceInfo) {
        data['deviceType'] = 'android';
        data['deviceName'] = info.model;
        data['deviceVersion'] = '${info.version.sdkInt}';
        data['deviceManufacturer'] = info.manufacturer;
        data['deviceBrand'] = info.brand;
        data['deviceIsPhysical'] = '${info.isPhysicalDevice}';
      } else if (info is IosDeviceInfo) {
        data['deviceType'] = 'ios';
        data['deviceName'] = info.model;
        data['deviceVersion'] = info.systemVersion;
        data['deviceManufacturer'] = info.utsname.machine;
        data['deviceBrand'] = info.utsname.machine;
        data['deviceIsPhysical'] = '${info.isPhysicalDevice}';
      } else if (info is WebBrowserInfo) {
        data['deviceType'] = 'web';
        data['deviceName'] = info.userAgent ?? 'unknown';
        data['deviceVersion'] = info.userAgent ?? 'unknown';
        data['deviceManufacturer'] = 'unknown';
        data['deviceBrand'] = 'unknown';
        data['deviceIsPhysical'] = 'true';
      }
      final response = await dio.post(
        loginPath,
        data: data,
      );
      if (response.statusCode == 200) {
        final user =
            ResturantOperator.fromJson(response.data ?? <String, dynamic>{});
        return JsonResponse.success(
          message: 'Operator logged in successfully!',
          data: user,
        );
      } else {
        final error =
            response.data?['message']?.toString() ?? 'Something went wrong!';
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: error,
        );
      }
    } on DioException catch (e) {
      final message = e.response?.data?['message']?.toString() ?? e.message;
      return JsonResponse.failure(
        statusCode: e.response?.statusCode ?? 500,
        message: message.toString(),
      );
    } on Exception {
      return JsonResponse.failure(
        statusCode: 500,
        message: 'Error : Unexpected error occurred.',
      );
    }
  }
}
