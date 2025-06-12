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
import 'package:pet_pocketbase/core/di/modules/local_storage_module.dart'
    as _i116;
import 'package:pet_pocketbase/core/pocketbase/pocketbase_service.dart'
    as _i196;
import 'package:pet_pocketbase/core/routing/app_router.dart' as _i557;
import 'package:pet_pocketbase/core/routing/guards/auth_guard.dart' as _i917;
import 'package:pet_pocketbase/core/storage/local_storage.dart' as _i861;
import 'package:pet_pocketbase/features/auth/data/repositories/auth_repository_impl.dart'
    as _i206;
import 'package:pet_pocketbase/features/auth/domain/cubits/auth_cubit.dart'
    as _i454;
import 'package:pet_pocketbase/features/auth/domain/repositories/auth_repository.dart'
    as _i500;
import 'package:pet_pocketbase/features/profile/data/repositories/profile_repository_impl.dart'
    as _i486;
import 'package:pet_pocketbase/features/profile/domain/cubits/profile_cubit.dart'
    as _i813;
import 'package:pet_pocketbase/features/profile/domain/repositories/profile_repository.dart'
    as _i82;
import 'package:pet_pocketbase/features/tasks/data/repositories/tasks_repository_impl.dart'
    as _i803;
import 'package:pet_pocketbase/features/tasks/domain/cubits/tasks_cubit.dart'
    as _i480;
import 'package:pet_pocketbase/features/tasks/domain/repositories/tasks_repository.dart'
    as _i737;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $configureDependencies(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final localStorageModule = _$LocalStorageModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => localStorageModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i557.AppRouter>(() => _i557.AppRouter());
  gh.singleton<_i861.LocalStorage>(
    () => _i861.LocalStorage(gh<_i460.SharedPreferences>()),
  );
  gh.lazySingleton<_i196.PocketBaseService>(
    () => _i196.PocketBaseService(gh<_i861.LocalStorage>()),
  );
  gh.lazySingleton<_i917.AuthGuard>(
    () => _i917.AuthGuard(gh<_i196.PocketBaseService>()),
  );
  gh.factory<_i737.TasksRepository>(
    () => _i803.TasksRepositoryImpl(gh<_i196.PocketBaseService>()),
  );
  gh.factory<_i82.ProfileRepository>(
    () => _i486.ProfileRepositoryImpl(gh<_i196.PocketBaseService>()),
  );
  gh.factory<_i480.TasksCubit>(
    () => _i480.TasksCubit(gh<_i737.TasksRepository>()),
  );
  gh.factory<_i500.AuthRepository>(
    () => _i206.AuthRepositoryImpl(gh<_i196.PocketBaseService>()),
  );
  gh.factory<_i813.ProfileCubit>(
    () => _i813.ProfileCubit(gh<_i82.ProfileRepository>()),
  );
  gh.factory<_i454.AuthCubit>(
    () => _i454.AuthCubit(gh<_i500.AuthRepository>()),
  );
  return getIt;
}

class _$LocalStorageModule extends _i116.LocalStorageModule {}
