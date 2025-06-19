import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _pbTokenKey = 'pb_token';

@lazySingleton
class LocalStorage {
  final SharedPreferences _box;
  LocalStorage(this._box);

  Future<void> saveAuthToken(String data) {
    return _box.setString(_pbTokenKey, data);
  }

  String? getAuthToken() {
    return _box.getString(_pbTokenKey);
  }

  Future<void> clearAuthToken() {
    return _box.remove(_pbTokenKey);
  }
}
