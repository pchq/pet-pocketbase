// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/cubits/auth_cubit.dart' as _i255;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i334;
import '../../features/profile/domain/cubits/profile_cubit.dart' as _i1022;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/tasks/data/repositories/tasks_repository_impl.dart'
    as _i220;
import '../../features/tasks/domain/cubits/tasks_cubit.dart' as _i672;
import '../../features/tasks/domain/repositories/tasks_repository.dart'
    as _i615;
import '../pocketbase/pocketbase_service.dart' as _i927;
import '../routing/app_router.dart' as _i282;
import '../routing/guards/auth_guard.dart' as _i381;
import '../storage/local_storage.dart' as _i329;
import 'modules/local_storage_module.dart' as _i170;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> $configureDependencies({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localStorageModule = _$LocalStorageModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => localStorageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i282.AppRouter>(() => _i282.AppRouter());
    gh.lazySingleton<_i329.LocalStorage>(
      () => _i329.LocalStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i927.PocketBaseService>(
      () => _i927.PocketBaseService(gh<_i329.LocalStorage>()),
    );
    gh.lazySingleton<_i381.AuthGuard>(
      () => _i381.AuthGuard(gh<_i927.PocketBaseService>()),
    );
    gh.factory<_i615.TasksRepository>(
      () => _i220.TasksRepositoryImpl(gh<_i927.PocketBaseService>()),
    );
    gh.factory<_i894.ProfileRepository>(
      () => _i334.ProfileRepositoryImpl(gh<_i927.PocketBaseService>()),
    );
    gh.factory<_i672.TasksCubit>(
      () => _i672.TasksCubit(gh<_i615.TasksRepository>()),
    );
    gh.factory<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i927.PocketBaseService>()),
    );
    gh.factory<_i1022.ProfileCubit>(
      () => _i1022.ProfileCubit(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i255.AuthCubit>(
      () => _i255.AuthCubit(gh<_i787.AuthRepository>()),
    );
    return this;
  }
}

class _$LocalStorageModule extends _i170.LocalStorageModule {}
