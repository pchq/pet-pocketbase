import 'package:injectable/injectable.dart';

import '../../../../core/pocketbase/pocketbase_service.dart';

import '../../domain/repositories/profile_repository.dart';
import '../models/user.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final PocketBaseService _pocketBaseService;

  const ProfileRepositoryImpl(this._pocketBaseService);

  @override
  void logout() {
    return _pocketBaseService.pb.authStore.clear();
  }

  @override
  Future<User> getUser() async {
    final userMap = _pocketBaseService.pb.authStore.record?.data;
    if (userMap == null) throw Exception('No user data');

    return User.fromJson(userMap);
  }
}
