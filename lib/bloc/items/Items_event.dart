part of 'items_bloc.dart';

sealed class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class GetAllProducts extends ItemsEvent {
  const GetAllProducts();

  @override
  List<Object> get props => [];
}

class UpdateProductStatus extends ItemsEvent {
  const UpdateProductStatus({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}

class DeleteProduct extends ItemsEvent {
  const DeleteProduct({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
