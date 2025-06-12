enum RecordAction {
  create,
  delete,
  update;

  factory RecordAction.fromString(String action) {
    return values.firstWhere((e) => e.name == action);
  }
}
