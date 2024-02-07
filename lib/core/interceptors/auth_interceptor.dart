import 'package:dine_in_resturant/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// [AuthInterceptor] is a [Interceptor] that adds the authorization header to the request.
/// [AuthInterceptor] is used to add the authorization header to the request

class AuthInterceptor extends Interceptor {
  /// [AuthInterceptor] constructor.
  AuthInterceptor();
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await HydratedBloc.storage.read(kUser);
    options.headers = {
      ...options.headers,
      'Authorization': 'Bearer $token',
    };
    return handler.next(options);
  }
}
