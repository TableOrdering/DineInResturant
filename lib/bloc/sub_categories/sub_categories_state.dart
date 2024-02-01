part of 'sub_categories_bloc.dart';

class SubCategoriesState extends Equatable {
  const SubCategoriesState({
    this.subCategoryData = const <SubCategory>[],
    this.isLoading = false,
    this.message = '',
    this.error = '',
    this.hasReachedMax = false,
    this.page = 0,
    this.limit = 4000,
  });

  final List<SubCategory> subCategoryData;
  final bool isLoading;
  final String message;
  final String error;
  final bool hasReachedMax;
  final int page;
  final int limit;

  SubCategoriesState copyWith({
    List<SubCategory>? subCategoryData,
    bool? isLoading,
    String? message,
    String? error,
    bool? hasReachedMax,
    int? page,
    int? limit,
  }) =>
      SubCategoriesState(
        subCategoryData: subCategoryData ?? this.subCategoryData,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page,
        limit: limit ?? this.limit,
      );

  /// fromJson and toJson are not necessary, but they can help in case you need to

  factory SubCategoriesState.fromJson(Map<String, dynamic> json) =>
      SubCategoriesState(
        subCategoryData: List<SubCategory>.from(
          json["subCategoryData"]?.map((x) => SubCategory.fromJson(x)) ??
              <SubCategory>[],
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
