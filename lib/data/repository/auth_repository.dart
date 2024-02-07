
import 'package:dine_in_resturant/data/model/json_response.dart';
import 'package:dine_in_resturant/data/services/auth_service.dart';

/// [AuthRepository] is an abstract class that defines the methods that will be
/// implemented by the [AuthRepositoryImpl] class.
abstract class AuthRepository {
  Future<JsonResponse> logIn(String phone, String password);
}

/// [AuthRepositoryImpl] is a class that implements the [AuthRepository] class.
/// It is responsible for calling the methods of the [AuthService] class.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.authService});
  final AuthService authService;
  @override
  Future<JsonResponse> logIn(String phone, String password) =>
      authService.logIn(phone: phone, password: password);
}
