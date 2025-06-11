part of 'profile_cubit.dart';

class ProfileState implements BaseState {
  final StateStatus status;
  final String? errorMessage;
  final User? user;

  const ProfileState({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.user,
  });

  ProfileState copyWith({
    StateStatus? status,
    String? errorMessage,
    User? user,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
