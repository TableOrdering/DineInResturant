part of 'sub_categories_bloc.dart';

sealed class SubCategoriesEvent extends Equatable {
  const SubCategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetAllSubCategories extends SubCategoriesEvent {
  const GetAllSubCategories();

  @override
  List<Object> get props => [];
}

class SubCategoryStatus extends SubCategoriesEvent {
  const SubCategoryStatus({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
