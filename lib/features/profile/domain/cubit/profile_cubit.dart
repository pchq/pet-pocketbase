import 'package:injectable/injectable.dart';

import '../../../../core/base_cubit/base_cubit.dart';
import '../../data/models/user.dart';
import '../repositories/profile_repository.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends BaseCubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(const ProfileState()) {
    _init();
  }

  @override
  void handleError(String message) {
    emit(state.copyWith(status: StateStatus.error, errorMessage: message));
  }

  Future<void> _init() async {
    emit(state.copyWith(status: StateStatus.loading));

    await makeErrorHandledCall(() async {
      final user = await _profileRepository.getUser();
      emit(state.copyWith(status: StateStatus.success, user: user));
    });
  }

  Future<void> logout() async {
    emit(state.copyWith(status: StateStatus.loading));

    await makeErrorHandledCall(() async {
      _profileRepository.logout();
      emit(state.copyWith(status: StateStatus.success));
    });
  }
}
