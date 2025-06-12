import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  static const userFieldKey = 'user';

  final String? id;
  @JsonKey(name: userFieldKey)
  final String? userId;
  final String title;
  final bool isDone;

  Task({this.id, this.userId, required this.title, this.isDone = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({String? id, String? userId, String? title, bool? isDone}) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
