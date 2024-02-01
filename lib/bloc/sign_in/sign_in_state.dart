part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.isBusy = false,
    this.user = const ResturantOperator(),
    this.message = '',
    this.error = '',
  });
  final bool isBusy;
  final ResturantOperator user;
  final String message;
  final String error;

  /// [copyWith] returns a new [SignInState] with the updated values.

  SignInState copyWith({
    bool? isBusy,
    ResturantOperator? user,
    String? message,
    String? error,
  }) {
    return SignInState(
      isBusy: isBusy ?? this.isBusy,
      user: user ?? this.user,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  factory SignInState.fromJson(Map<String, dynamic> json) => SignInState(
        user:
            ResturantOperator.fromJson(json['Operator'] ?? <String, dynamic>{}),
      );

  Map<String, dynamic> toJson() => {
        'Operator': user.toJson(),
      };

  @override
  List<Object> get props => [isBusy, user, message, error];
}
