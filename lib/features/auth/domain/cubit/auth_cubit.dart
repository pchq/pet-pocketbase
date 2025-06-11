import 'package:injectable/injectable.dart';

import '../../../../core/base_cubit/base_cubit.dart';
import '../repositories/auth_repository.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends BaseCubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState());

  @override
  void handleError(String message) {
    emit(state.copyWith(status: StateStatus.error, errorMessage: message));
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: StateStatus.loading));

    await makeErrorHandledCall(() async {
      await _authRepository.login(email, password);
      emit(state.copyWith(status: StateStatus.success));
    });
  }

  Future<void> register(String email, String password) async {
    emit(state.copyWith(status: StateStatus.loading));

    await makeErrorHandledCall(() async {
      await _authRepository.register(email, password);
      emit(state.copyWith(status: StateStatus.success));
    });
  }
}
