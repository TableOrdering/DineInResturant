import 'package:dine_in/data/model/json_response.dart';
import 'package:dine_in/data/model/tables/tables.dart';
import 'package:dine_in/data/services/tables/tables_service.dart';

abstract class TablesRepo {
  Future<JsonResponse> getAllTables();
  Future<JsonResponse> updateTableStatus(String id);
  Future<JsonResponse> createTable(TableModel table);
  Future<JsonResponse> updateTable(TableModel table);
  Future<JsonResponse> deleteTable(String id);
}

class TablesRepoImp implements TablesRepo {
  TablesRepoImp({required this.service});
  final TablesService service;

  @override
  Future<JsonResponse> getAllTables() => service.getAllTables();

  @override
  Future<JsonResponse> updateTableStatus(String id) =>
      service.updateTableStatus(id);

  @override
  Future<JsonResponse> createTable(TableModel table) =>
      service.createTable(table);

  @override
  Future<JsonResponse> deleteTable(String id) => service.deleteTable(id);

  @override
  Future<JsonResponse> updateTable(TableModel table) =>
      service.updateTable(table);
}
