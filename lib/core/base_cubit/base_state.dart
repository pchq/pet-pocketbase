part of 'base_cubit.dart';

abstract class BaseState {
  final StateStatus status;
  final String? errorMessage;

  BaseState(this.status, [this.errorMessage]);

  BaseState copyWith({StateStatus? status, String? errorMessage});
}
