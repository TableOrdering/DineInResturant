// part of 'in_active_items_bloc.dart';

// class InActiveItemsState extends Equatable {
//   const InActiveItemsState({
//     this.inActiveItemsData = const <InActiveItems>[],
//     this.isLoading = false,
//     this.message = '',
//     this.error = '',
//     this.hasReachedMax = false,
//     this.page = 0,
//     this.limit = 40,
//   });

//   final List<InActiveItems> inActiveItemsData;
//   final bool isLoading;
//   final String message;
//   final String error;
//   final bool hasReachedMax;
//   final int page;
//   final int limit;

//   InActiveItemsState copyWith({
//     List<InActiveItems>? inActiveItemsData,
//     bool? isLoading,
//     String? message,
//     String? error,
//     bool? hasReachedMax,
//     int? page,
//     int? limit,
//   }) =>
//       InActiveItemsState(
//         inActiveItemsData: inActiveItemsData ?? this.inActiveItemsData,
//         isLoading: isLoading ?? this.isLoading,
//         message: message ?? this.message,
//         error: error ?? this.error,
//         hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//         page: page ?? this.page,
//         limit: limit ?? this.limit,
//       );

//   /// fromJson and toJson are not necessary, but they can help in case you need to

//   factory InActiveItemsState.fromJson(Map<String, dynamic> json) =>
//       InActiveItemsState(
//         inActiveItemsData: List<InActiveItems>.from(
//           json["inActiveItemsData"]?.map((x) => InActiveItems.fromJson(x)) ??
//               <InActiveItems>[],
//         ),
//       );

//   Map<String, dynamic> toJson() => {
//         "inActiveItemsData": inActiveItemsData.map((x) => x.toJson()).toList(),
//       };

//   @override
//   List<Object> get props => [
//         inActiveItemsData,
//         isLoading,
//         message,
//         error,
//         hasReachedMax,
//         page,
//         limit,
//       ];
// }
