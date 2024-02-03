import 'package:dine_in/data/model/json_response.dart';
import 'package:dine_in/data/services/tables/tables_service.dart';

abstract class TablesRepo {
  Future<JsonResponse> getAllTables();
  Future<JsonResponse> updateTableStatus(String id);
}

class TablesRepoImp implements TablesRepo {
  TablesRepoImp({required this.service});
  final TablesService service;

  @override
  Future<JsonResponse> getAllTables() => service.getAllTables();

  @override
  Future<JsonResponse> updateTableStatus(String id) =>
      service.updateTableStatus(id);
}
