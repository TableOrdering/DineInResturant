part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
  @override
  List<Object> get props => [];
}

class LogInEvent extends SignInEvent {
  const LogInEvent({
    required this.phone,
    required this.password,
  });
  final String phone;
  final String password;
  @override
  List<Object> get props => [phone, password];
}

class LogOutEvent extends SignInEvent {
  const LogOutEvent();
  @override
  List<Object> get props => [];
}
