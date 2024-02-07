import 'dart:async';

import 'package:dine_in_resturant/data/model/tables/tables.dart';
import 'package:dine_in_resturant/data/repository/tablse_repo/table_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tables_event.dart';
part 'tables_state.dart';

class TablesBloc extends HydratedBloc<TablesEvent, TablesState> {
  TablesBloc({required this.repository}) : super(const TablesState()) {
    on<GetAllTables>(_onGetAllTables);
    on<TableStatus>(_onTableStatus);
    on<CreateTable>(_onCreateTable);
    on<UpdateTable>(_onUpdateTable);
    on<DeleteTable>(_onDeleteTable);
  }
  final TablesRepo repository;

  FutureOr<void> _onGetAllTables(
      GetAllTables event, Emitter<TablesState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.getAllTables();
      if (response.success) {
        final data = response.data as List<TableModel>;
        emit(
          state.copyWith(
            isLoading: false,
            tablesdata: [...data],
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  FutureOr<void> _onTableStatus(
      TableStatus event, Emitter<TablesState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.updateTableStatus(event.id);
      if (response.success) {
        emit(
          state.copyWith(
            isLoading: false,
            message: response.message,
          ),
        );
        add(const GetAllTables());
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  FutureOr<void> _onCreateTable(
      CreateTable event, Emitter<TablesState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.createTable(event.table);
      if (response.success) {
        emit(
          state.copyWith(
            isLoading: false,
            message: response.message,
          ),
        );
        add(const GetAllTables());
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  FutureOr<void> _onUpdateTable(
      UpdateTable event, Emitter<TablesState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.updateTable(event.table);
      if (response.success) {
        emit(
          state.copyWith(
            isLoading: false,
            message: response.message,
          ),
        );
        add(const GetAllTables());
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  FutureOr<void> _onDeleteTable(
      DeleteTable event, Emitter<TablesState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.deleteTable(event.id);
      if (response.success) {
        emit(
          state.copyWith(
            isLoading: false,
            message: response.message,
          ),
        );
        add(const GetAllTables());
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  @override
  TablesState? fromJson(Map<String, dynamic> json) =>
      TablesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(TablesState state) => state.toJson();
}
