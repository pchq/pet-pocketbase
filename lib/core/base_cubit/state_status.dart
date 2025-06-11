part of 'base_cubit.dart';

enum StateStatus {
  initial,
  loading,
  success,
  error;

  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isError => this == error;
}
