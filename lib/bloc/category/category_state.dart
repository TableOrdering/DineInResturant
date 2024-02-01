part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.categoriesData = const <CategoryModel>[],
    this.isLoading = false,
    this.message = '',
    this.error = '',
    this.hasReachedMax = false,
    this.page = 0,
    this.limit = 4000,
  });

  final List<CategoryModel> categoriesData;
  final bool isLoading;
  final String message;
  final String error;
  final bool hasReachedMax;
  final int page;
  final int limit;

  CategoryState copyWith({
    List<CategoryModel>? categoriesData,
    bool? isLoading,
    String? message,
    String? error,
    bool? hasReachedMax,
    int? page,
    int? limit,
  }) =>
      CategoryState(
        categoriesData: categoriesData ?? this.categoriesData,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page,
        limit: limit ?? this.limit,
      );

  /// fromJson and toJson are not necessary, but they can help in case you need to

  factory CategoryState.fromJson(Map<String, dynamic> json) => CategoryState(
        categoriesData: List<CategoryModel>.from(
          json["categoriesData"]?.map((x) => CategoryModel.fromJson(x)) ??
              <CategoryModel>[],
        ),
      );

  Map<String, dynamic> toJson() => {
        "categoriesData": categoriesData.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object> get props => [
        categoriesData,
        isLoading,
        message,
        error,
        hasReachedMax,
        page,
        limit,
      ];
}
