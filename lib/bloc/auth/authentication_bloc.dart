import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState>
    with ChangeNotifier {
  AuthenticationBloc() : super(AuthenticationState.unauthenticated) {
    on<AuthenticationAuthenticated>(_onAuthenticationAuthenticated);
    on<AuthenticationUnAuthenticated>(_onAuthenticationUnAuthenticated);
  }

  FutureOr<void> _onAuthenticationAuthenticated(
      AuthenticationAuthenticated event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationState.authenticated);
    notifyListeners();
  }

  FutureOr<void> _onAuthenticationUnAuthenticated(
      AuthenticationUnAuthenticated event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationState.unauthenticated);
    notifyListeners();
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    try {
      return AuthenticationState
          .values[int.tryParse('${json['AuthenticationState']}') ?? 0];
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    try {
      return {'AuthenticationState': state.index};
    } catch (_) {
      return null;
    }
  }
}
