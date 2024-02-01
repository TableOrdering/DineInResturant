import 'dart:async';

import 'package:dine_in/data/model/category/category.dart';
import 'package:dine_in/data/repository/catrgory_repo/category_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends HydratedBloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.repository}) : super(const CategoryState()) {
    on<GetAllCategories>(_onGetAllCategories);
    on<CategoryStatus>(_onCategoryStatus);
  }
  final CategoryRepository repository;
  FutureOr<void> _onGetAllCategories(
      GetAllCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response =
          await repository.getAllCategories(state.page, state.limit);
      if (response.success) {
        final data = response.data as List<CategoryModel>;
        emit(
          state.copyWith(
            isLoading: false,
            categoriesData: [...data],
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  FutureOr<void> _onCategoryStatus(
      CategoryStatus event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.updateCategoryStatus(event.id);
      if (response.success) {
        emit(
          state.copyWith(
            isLoading: false,
            message: response.message,
          ),
        );
        add(const GetAllCategories());
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  @override
  CategoryState? fromJson(Map<String, dynamic> json) =>
      CategoryState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CategoryState state) => state.toJson();
}
