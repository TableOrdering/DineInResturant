import 'dart:async';
import 'package:dine_in/data/model/category/sub_category.dart';
import 'package:dine_in/data/repository/catrgory_repo/category_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'Items_event.dart';
part 'items_state.dart';

class ItemsBloc extends HydratedBloc<ItemsEvent, ItemsState> {
  ItemsBloc({required this.repository}) : super(const ItemsState()) {
    on<GetAllProducts>(_onGetAllSubCategories);
    on<UpdateProductStatus>(_onSubCategoryStatus);
    on<DeleteProduct>(_onDeleteProductStatus);
  }
  final CategoryRepository repository;

  FutureOr<void> _onGetAllSubCategories(
      GetAllProducts event, Emitter<ItemsState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.getAllItems(state.page, state.limit);
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
      UpdateProductStatus event, Emitter<ItemsState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.updateProductStatus(event.id);
      if (response.success) {
        emit(
          state.copyWith(
            isLoading: false,
            message: response.message,
          ),
        );
        add(const GetAllProducts());
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  FutureOr<void> _onDeleteProductStatus(
      DeleteProduct event, Emitter<ItemsState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', message: ''));
    try {
      final response = await repository.deleteProduct(event.id);
      if (response.success) {
        emit(
          state.copyWith(
            isLoading: false,
            message: response.message,
          ),
        );
        add(const GetAllProducts());
      } else {
        emit(state.copyWith(isLoading: false, error: response.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  @override
  ItemsState? fromJson(Map<String, dynamic> json) => ItemsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ItemsState state) => state.toJson();
}
