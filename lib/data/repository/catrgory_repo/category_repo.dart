import 'package:dine_in/data/model/json_response.dart';
import 'package:dine_in/data/services/category/category_service.dart';

abstract class CategoryRepository {
  Future<JsonResponse> getAllCategories(int page, int limit);
  Future<JsonResponse> updateCategoryStatus(String id);
  Future<JsonResponse> updateSubCategoryStatus(String id);
  Future<JsonResponse> getAllSubCategories(int page, int limit);
}

class CategoryRepoImp implements CategoryRepository {
  CategoryRepoImp({required this.service});
  final CategoryService service;

  @override
  Future<JsonResponse> getAllCategories(int page, int limit) =>
      service.getAllCategories(page, limit);

  @override
  Future<JsonResponse> updateCategoryStatus(String id) =>
      service.updateCategoryStatus(id);

  @override
  Future<JsonResponse> getAllSubCategories(int page, int limit) =>
      service.getAllSubCategories(page, limit);

  @override
  Future<JsonResponse> updateSubCategoryStatus(String id) =>
      service.updateSubCategoryStatus(id);
}
