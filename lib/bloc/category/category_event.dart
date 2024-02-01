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

class CategoryStatus extends CategoryEvent {
  const CategoryStatus({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
