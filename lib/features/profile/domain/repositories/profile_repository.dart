import '../../data/models/user.dart';

abstract class ProfileRepository {
  void logout();
  Future<User> getUser();
}
