import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [AppBlocObserver] is a [BlocObserver] that logs all events and states.
/// It is used to debug the application.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('On Change(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('On Error(${bloc.runtimeType}, $error, $stackTrace)');
  }
}
