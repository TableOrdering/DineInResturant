import 'dart:async';
import 'package:dine_in/data/model/category/sub_category.dart';
import 'package:dine_in/data/repository/catrgory_repo/category_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'sub_categories_event.dart';
part 'sub_categories_state.dart';

class SubCategoriesBloc
    extends HydratedBloc<SubCategoriesEvent, SubCategoriesState> {
  SubCategoriesBloc({required this.repository})
      : super(const SubCategoriesState()) {
    on<GetAllSubCategories>(_onGetAllSubCategories);
    on<SubCategoryStatus>(_onSubCategoryStatus);
  }
  final CategoryRepository repository;

  FutureOr<void> _onGetAllSubCategories(
      GetAllSubCategories event, Emitter<SubCategoriesState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response =
          await repository.getAllSubCategories(state.page, state.limit);
      if (response.success) {
        final data = response.data as List<SubCategory>;
        emit(
          state.copyWith(
            isLoading: false,
            subCategoryData: [...data],
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  FutureOr<void> _onSubCategoryStatus(
      SubCategoryStatus event, Emitter<SubCategoriesState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.updateSubCategoryStatus(event.id);
      if (response.success) {
        emit(
          state.copyWith(
            isLoading: false,
            message: response.message,
          ),
        );
        add(const GetAllSubCategories());
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  @override
  SubCategoriesState? fromJson(Map<String, dynamic> json) =>
      SubCategoriesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SubCategoriesState state) => state.toJson();
}
