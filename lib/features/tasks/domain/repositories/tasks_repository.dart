import '../../data/models/record_action.dart';
import '../../data/models/task.dart';

abstract class TasksRepository {
  Future<List<Task>> getList();
  Stream<(Task, RecordAction)> updateStream();
  Future<void> add(Task task);
  Future<void> delete(Task task);
  Future<void> update(Task task);
  Future<void> dispose();
}
