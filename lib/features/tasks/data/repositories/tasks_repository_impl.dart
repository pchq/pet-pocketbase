import 'package:injectable/injectable.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/pocketbase/collections.dart';
import '../../../../core/pocketbase/pocketbase_service.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../models/record_action.dart';
import '../models/task.dart';

@Injectable(as: TasksRepository)
class TasksRepositoryImpl implements TasksRepository {
  final PocketBaseService _pocketBaseService;

  const TasksRepositoryImpl(this._pocketBaseService);

  RecordService get _collection =>
      _pocketBaseService.pb.collection(PbCollection.tasks.name);

  String get _userId {
    final id = _pocketBaseService.pb.authStore.record?.id;
    if (id == null) {
      throw Exception('Authorization error');
    }
    return id;
  }

  String get _filter => '${Task.userFieldKey}="$_userId"';

  @override
  Future<List<Task>> getList() async {
    final records = await _collection.getFullList(filter: _filter);
    return records.map((item) => Task.fromJson(item.data)).toList();
  }

  @override
  Future<void> add(Task rawTask) {
    final task = rawTask.copyWith(userId: _userId);
    return _collection.create(body: task.toJson());
  }

  @override
  Future<void> delete(Task task) {
    final id = task.id;
    if (id == null || task.userId != _userId) {
      throw Exception('No access');
    }
    return _collection.delete(id);
  }

  @override
  Future<void> dispose() {
    return _pocketBaseService.pb
        .collection(PbCollection.tasks.name)
        .unsubscribe();
  }

  @override
  Stream<(Task, RecordAction)> updateStream() {
    final bObject = BehaviorSubject<(Task, RecordAction)>();
    _pocketBaseService.pb.collection(PbCollection.tasks.name).subscribe('*', (
      e,
    ) {
      final record = e.record;
      if (record == null) return;

      final action = RecordAction.fromString(e.action);
      final task = Task.fromJson(record.data);
      bObject.add((task, action));
    }, filter: _filter);

    return bObject.stream;
  }

  @override
  Future<void> update(Task task) async {
    final id = task.id;
    if (id == null) {
      return;
    }

    await _collection.update(id, body: task.toJson());
  }
}
