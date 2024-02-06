part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategories extends CategoryEvent {
  const GetAllCategories();

  @override
  List<Object> get props => [];
}

class CreateCategory extends CategoryEvent {
  const CreateCategory({required this.model});
  final CreateCategoryModel model;

  @override
  List<Object> get props => [model];
}

class CategoryStatus extends CategoryEvent {
  const CategoryStatus({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}

class DeleteCategory extends CategoryEvent {
  const DeleteCategory({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
