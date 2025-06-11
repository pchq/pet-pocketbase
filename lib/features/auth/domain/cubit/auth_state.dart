part of 'auth_cubit.dart';

class AuthState implements BaseState {
  final StateStatus status;
  final String? errorMessage;

  const AuthState({this.status = StateStatus.initial, this.errorMessage});

  AuthState copyWith({StateStatus? status, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
