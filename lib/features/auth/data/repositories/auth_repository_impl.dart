import 'package:injectable/injectable.dart';

import '../../../../core/pocketbase/collections.dart';
import '../../../../core/pocketbase/pocketbase_service.dart';
import '../../domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final PocketBaseService _pocketBaseService;

  const AuthRepositoryImpl(this._pocketBaseService);

  @override
  Future<void> login(String email, String password) async {
    await _pocketBaseService.pb
        .collection(PbCollection.users.name)
        .authWithPassword(email, password);
  }

  @override
  Future<void> register(String email, String password) async {
    await _pocketBaseService.pb
        .collection(PbCollection.users.name)
        .create(
          body: {
            'email': email,
            'password': password,
            'passwordConfirm': password,
          },
        );
    return login(email, password);
  }
}
