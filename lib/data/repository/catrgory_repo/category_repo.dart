import 'package:dine_in/data/model/extensions_models/create_category_extension.dart';
import 'package:dine_in/data/model/extensions_models/create_product_extension.dart';
import 'package:dine_in/data/model/json_response.dart';
import 'package:dine_in/data/services/category/category_service.dart';

abstract class CategoryRepository {
  Future<JsonResponse> getAllCategories(int page, int limit);
  Future<JsonResponse> updateCategoryStatus(String id);
  Future<JsonResponse> createCategory(CreateCategoryExtension model);
  Future<JsonResponse> deleteCategory(String id);

  /// Product Part
  Future<JsonResponse> createProduct(CreateItemExtension model);
  Future<JsonResponse> getAllItems(int page, int limit);
  Future<JsonResponse> updateProductStatus(String id);
  Future<JsonResponse> deleteProduct(String id);
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
  Future<JsonResponse> getAllItems(int page, int limit) =>
      service.getAllItems(page, limit);

  @override
  Future<JsonResponse> updateProductStatus(String id) =>
      service.updateProductStatus(id);

  @override
  Future<JsonResponse> deleteProduct(String id) => service.deleteProduct(id);

  @override
  Future<JsonResponse> createCategory(CreateCategoryExtension model) =>
      service.createCategory(model);

  @override
  Future<JsonResponse> deleteCategory(String id) => service.deleteCategory(id);

  @override
  Future<JsonResponse> createProduct(CreateItemExtension model) =>
      service.createProduct(model);
}
