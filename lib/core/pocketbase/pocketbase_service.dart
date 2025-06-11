import 'dart:io' show Platform;

import 'package:injectable/injectable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../storage/local_storage.dart';

@singleton
class PocketBaseService {
  final LocalStorage _storage;
  late final PocketBase pb;

  PocketBaseService(this._storage) {
    _init();
  }

  String get _host => (Platform.isAndroid) ? '10.0.2.2' : '127.0.0.1';

  void _init() {
    final customAuthStore = AsyncAuthStore(
      initial: _storage.getAuthToken(),
      save: _storage.saveAuthToken,
      clear: _storage.clearAuthToken,
    );

    pb = PocketBase('http://$_host:8090/', authStore: customAuthStore);
  }
}
