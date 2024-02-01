// import 'dart:async';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'in_active_items_event.dart';
// part 'in_active_items_state.dart';

// class InActiveItemsBloc extends Bloc<InActiveItemsEvent, InActiveItemsState> {
//   InActiveItemsBloc({required this.repository})
//       : super(const InActiveItemsState()) {
//     on<GetAllInActiveItems>(_onGetAllInActiveItems);
//   }
//   final AdminRepository repository;

//   FutureOr<void> _onGetAllInActiveItems(
//       GetAllInActiveItems event, Emitter<InActiveItemsState> emit) async {
//     if (state.hasReachedMax) return;
//     if (event.refresh) {
//       emit(const InActiveItemsState());
//     }
//     emit(state.copyWith(isLoading: true, error: '', message: ''));
//     final oldItems = state.inActiveItemsData;
//     try {
//       final response = await repository.storeInActiveItems(
//         id: event.id,
//         page: state.page,
//         limit: state.limit,
//       );
//       if (response.success) {
//         final items = response.data as List<InActiveItems>;
//         emit(state.copyWith(
//           isLoading: false,
//           inActiveItemsData: [...oldItems, ...items],
//           hasReachedMax: items.isEmpty || items.length < state.limit,
//           page: state.page + 1,
//         ));
//       } else {
//         emit(state.copyWith(isLoading: false, error: response.message));
//       }
//     } on Exception catch (e) {
//       emit(state.copyWith(isLoading: false, error: e.toString()));
//     }
//   }
// }
