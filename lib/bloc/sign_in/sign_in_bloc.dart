import 'dart:async';

import 'package:dine_in_resturant/bloc/auth/authentication_bloc.dart';
import 'package:dine_in_resturant/core/utils/constants.dart';
import 'package:dine_in_resturant/data/model/operator.dart';
import 'package:dine_in_resturant/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends HydratedBloc<SignInEvent, SignInState> {
  SignInBloc({required this.authenticationBloc, required this.repository})
      : super(const SignInState()) {
    on<LogInEvent>(_onLogIn);
    on<LogOutEvent>(_onLogOutEvent);
  }
  final AuthRepository repository;
  final AuthenticationBloc authenticationBloc;

  FutureOr<void> _onLogIn(LogInEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isBusy: true, message: '', error: ''));
    try {
      final response = await repository.logIn(event.phone, event.password);
      if (response.success) {
        final user = response.data as ResturantOperator;
        emit(state.copyWith(
          isBusy: false,
          user: user,
          message: response.message,
        ));
        await HydratedBloc.storage.write(kUser, user.token);
        authenticationBloc.add(AuthenticationAuthenticated());
      } else {
        emit(state.copyWith(
          error: response.message,
          isBusy: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        error: 'Something went wrong!',
        isBusy: false,
      ));
    } finally {
      emit(state.copyWith(
        isBusy: false,
        message: '',
        error: '',
      ));
    }
  }

  FutureOr<void> _onLogOutEvent(
      LogOutEvent event, Emitter<SignInState> emit) async {
    await HydratedBloc.storage.clear();
    authenticationBloc.add(AuthenticationUnAuthenticated());
  }

  @override
  SignInState? fromJson(Map<String, dynamic> json) =>
      SignInState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SignInState state) => state.toJson();
}
