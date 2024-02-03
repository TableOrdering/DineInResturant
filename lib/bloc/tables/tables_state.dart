part of 'tables_bloc.dart';

class TablesState extends Equatable {
  const TablesState({
    this.tablesdata = const <TableModel>[],
    this.isLoading = false,
    this.message = '',
    this.error = '',
    this.hasReachedMax = false,
    this.page = 0,
    this.limit = 4000,
  });

  final List<TableModel> tablesdata;
  final bool isLoading;
  final String message;
  final String error;
  final bool hasReachedMax;
  final int page;
  final int limit;

  TablesState copyWith({
    List<TableModel>? tablesdata,
    bool? isLoading,
    String? message,
    String? error,
    bool? hasReachedMax,
    int? page,
    int? limit,
  }) =>
      TablesState(
        tablesdata: tablesdata ?? this.tablesdata,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page,
        limit: limit ?? this.limit,
      );

  /// fromJson and toJson are not necessary, but they can help in case you need to

  factory TablesState.fromJson(Map<String, dynamic> json) => TablesState(
        tablesdata: List<TableModel>.from(
          json["tablesdata"]?.map((x) => TableModel.fromJson(x)) ??
              <TableModel>[],
        ),
      );

  Map<String, dynamic> toJson() => {
        "tablesdata": tablesdata.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object> get props => [
        tablesdata,
        isLoading,
        message,
        error,
        hasReachedMax,
        page,
        limit,
      ];
}
