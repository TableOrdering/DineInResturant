part of 'items_bloc.dart';

class ItemsState extends Equatable {
  const ItemsState({
    this.subCategoryData = const <ItemsModel>[],
    this.isLoading = false,
    this.message = '',
    this.error = '',
    this.hasReachedMax = false,
    this.page = 0,
    this.limit = 4000,
  });

  final List<ItemsModel> subCategoryData;
  final bool isLoading;
  final String message;
  final String error;
  final bool hasReachedMax;
  final int page;
  final int limit;

  ItemsState copyWith({
    List<ItemsModel>? subCategoryData,
    bool? isLoading,
    String? message,
    String? error,
    bool? hasReachedMax,
    int? page,
    int? limit,
  }) =>
      ItemsState(
        subCategoryData: subCategoryData ?? this.subCategoryData,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page,
        limit: limit ?? this.limit,
      );

  /// fromJson and toJson are not necessary, but they can help in case you need to

  factory ItemsState.fromJson(Map<String, dynamic> json) => ItemsState(
        subCategoryData: List<ItemsModel>.from(
          json["subCategoryData"]?.map((x) => ItemsModel.fromJson(x)) ??
              <ItemsModel>[],
        ),
      );

  Map<String, dynamic> toJson() => {
        "subCategoryData": subCategoryData.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object> get props => [
        subCategoryData,
        isLoading,
        message,
        error,
        hasReachedMax,
        page,
        limit,
      ];
}
