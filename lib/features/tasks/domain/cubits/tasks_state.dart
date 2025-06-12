part of 'tasks_cubit.dart';

class TasksState implements BaseState {
  final StateStatus status;
  final String? errorMessage;
  final List<Task> tasks;

  const TasksState({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.tasks = const [],
  });

  TasksState copyWith({
    StateStatus? status,
    String? errorMessage,
    List<Task>? tasks,
  }) {
    return TasksState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      tasks: tasks ?? this.tasks,
    );
  }
}
