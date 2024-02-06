import 'package:dine_in/core/interceptors/auth_interceptor.dart';
import 'package:dine_in/core/utils/constants.dart';
import 'package:dine_in/core/utils/helpers.dart';
import 'package:dine_in/data/model/category/category.dart';
import 'package:dine_in/data/model/category/sub_category.dart';
import 'package:dine_in/data/model/extensions_models/create_category_extension.dart';
import 'package:dine_in/data/model/json_response.dart';
import 'package:dio/dio.dart';

/// [CategoryService] is a class that handles all the authentication related
/// operations.
class CategoryService {
  /// constructor and assigning the [dio] instance with the base url and options
  /// for the api.
  CategoryService({required this.dio}) {
    dio.options.baseUrl = '$kURL$operatorPath';
    dio.options.sendTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.responseType = ResponseType.json;

    ///[LogInterceptor] is a interceptor that logs the request and response.
    ///It is used for debugging purpose.
    ///It is not used in production.

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
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(AuthInterceptor());
  }

  /// [dio] is the [Dio] instance used to make all the requests.
  /// [dio] is required to make all the requests.
  final Dio dio;

  Future<JsonResponse> getAllCategories(int page, int limit) async {
    try {
      final response = await dio.get(
        categoryPath,
        queryParameters: {
          "page": page,
          "limit": limit,
        },
      );
      if (response.statusCode == 200) {
        final data = List<CategoryModel>.from(
          response.data?.map(
                (dynamic item) => CategoryModel.fromJson(item),
              ) ??
              <CategoryModel>[],
        );
        return JsonResponse.success(
          message: 'Categories Fetches Successfully',
          data: <CategoryModel>[...data],
        );
      } else {
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: 'Failed to Get Categories!',
        );
      }
    } on DioException catch (e) {
      final message = e.message;
      return JsonResponse.failure(
        message: message.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  Future<JsonResponse> updateCategoryStatus(String id) async {
    try {
      final response = await dio.put(
        updateCategoryStatusPath,
        data: {
          "id": id,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: 'Status Updated',
        );
      } else {
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: 'Failed to Update Status!',
        );
      }
    } on DioException catch (e) {
      final message = e.message;
      return JsonResponse.failure(
        message: message.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  Future<JsonResponse> deleteCategory(String id) async {
    try {
      final response = await dio.delete(
        deleteCategoryPath,
        data: {
          "id": id,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: 'Deleted Category',
        );
      } else {
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: 'Failed to Delete Category!',
        );
      }
    } on DioException catch (e) {
      final message = e.message;
      return JsonResponse.failure(
        message: message.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  Future<JsonResponse> createCategory(CreateCategoryModel model) async {
    try {
      FormData formData = FormData.fromMap({
        'name': model.name,
        'description': model.description,
        'foodType': model.foodType,
        'isAvailable': model.isAvailable,
        'categoryImage': MultipartFile.fromBytes(
          model.image,
          filename: 'categoryImage.jpg',
        ),
      });
      final response = await dio.post(
        createCategoryPath,
        data: formData,
      );
      if (response.statusCode == 201) {
        return JsonResponse.success(
          message: 'Category Created',
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
        message: message.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  Future<JsonResponse> getAllItems(int page, int limit) async {
    try {
      final response = await dio.get(
        getProductPath,
        queryParameters: {
          "page": page,
          "limit": limit,
        },
      );
      if (response.statusCode == 200) {
        final data = List<SubCategory>.from(
          response.data?.map(
                (dynamic item) => SubCategory.fromJson(item),
              ) ??
              <SubCategory>[],
        );
        return JsonResponse.success(
          message: 'SubCategory Fetches Successfully',
          data: <SubCategory>[...data],
        );
      } else {
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: 'Failed to Get SubCategory!',
        );
      }
    } on DioException catch (e) {
      final message = e.message;
      return JsonResponse.failure(
        message: message.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  Future<JsonResponse> updateProductStatus(String id) async {
    try {
      final response = await dio.put(
        updateProductPath,
        data: {
          "id": id,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: 'Status Updated',
        );
      } else {
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: 'Failed to Update Status!',
        );
      }
    } on DioException catch (e) {
      final message = e.message;
      return JsonResponse.failure(
        message: message.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }

  Future<JsonResponse> deleteProduct(String id) async {
    try {
      final response = await dio.delete(
        deleteProductPath,
        data: {
          "id": id,
        },
      );
      if (response.statusCode == 200) {
        return JsonResponse.success(
          message: 'Status Updated',
        );
      } else {
        return JsonResponse.failure(
          statusCode: response.statusCode ?? 500,
          message: 'Failed to Update Status!',
        );
      }
    } on DioException catch (e) {
      final message = e.message;
      return JsonResponse.failure(
        message: message.toString(),
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (_) {
      return JsonResponse.failure(
        message: 'Something went wrong!',
      );
    }
  }
}
