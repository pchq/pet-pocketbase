import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../core/base_cubit/base_cubit.dart';
import '../../data/models/record_action.dart';
import '../../data/models/task.dart';
import '../repositories/tasks_repository.dart';

part 'tasks_state.dart';

@injectable
class TasksCubit extends BaseCubit<TasksState> {
  final TasksRepository _tasksRepository;

  TasksCubit(this._tasksRepository) : super(const TasksState()) {
    _init();
  }

  StreamSubscription<(Task, RecordAction)>? _streamSubscription;

  @override
  void handleError(String message) {
    emit(state.copyWith(status: StateStatus.error, errorMessage: message));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _tasksRepository.dispose();
    return super.close();
  }

  Future<void> _init() async {
    emit(state.copyWith(status: StateStatus.loading));

    await makeErrorHandledCall(() async {
      final tasks = await _tasksRepository.getList();
      emit(state.copyWith(status: StateStatus.success, tasks: tasks));

      _streamSubscription = _tasksRepository.updateStream().listen((value) {
        final (task, action) = value;

        switch (action) {
          case RecordAction.create:
            emit(state.copyWith(tasks: [...state.tasks, task]));
            break;
          case RecordAction.delete:
            final tasks = state.tasks
                .where((oldItem) => oldItem.id != task.id)
                .toList();

            emit(state.copyWith(tasks: tasks));
            break;
          case RecordAction.update:
            final tasks = state.tasks
                .map((oldItem) => oldItem.id == task.id ? task : oldItem)
                .toList();
            emit(state.copyWith(tasks: tasks));
            break;
        }
      });
    });
  }

  Future<void> add(Task task) async {
    emit(state.copyWith(status: StateStatus.loading));

    await makeErrorHandledCall(() async {
      await _tasksRepository.add(task);
      emit(state.copyWith(status: StateStatus.success));
    });
  }

  Future<void> changeStatus(Task task) async {
    emit(state.copyWith(status: StateStatus.loading));

    await makeErrorHandledCall(() async {
      final updatedTask = task.copyWith(isDone: !task.isDone);
      await _tasksRepository.update(updatedTask);
      emit(state.copyWith(status: StateStatus.success));
    });
  }

  Future<void> delete(Task task) async {
    emit(state.copyWith(status: StateStatus.loading));

    await makeErrorHandledCall(() async {
      await _tasksRepository.delete(task);
      emit(state.copyWith(status: StateStatus.success));
    });
  }
}
