part of 'tables_bloc.dart';

sealed class TablesEvent extends Equatable {
  const TablesEvent();

  @override
  List<Object> get props => [];
}

class GetAllTables extends TablesEvent {
  const GetAllTables();

  @override
  List<Object> get props => [];
}

class TableStatus extends TablesEvent {
  const TableStatus({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}

class CreateTable extends TablesEvent {
  const CreateTable({required this.table});
  final TableModel table;

  @override
  List<Object> get props => [table];
}

class DeleteTable extends TablesEvent {
  const DeleteTable({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}

class UpdateTable extends TablesEvent {
  const UpdateTable({required this.table});
  final TableModel table;

  @override
  List<Object> get props => [table];
}
