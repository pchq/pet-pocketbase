import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../pocketbase/pocketbase_service.dart';
import '../app_router.dart';

@singleton
class AuthGuard extends AutoRouteGuard {
  final PocketBaseService _pocketBaseService;

  const AuthGuard(this._pocketBaseService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_pocketBaseService.pb.authStore.isValid) {
      resolver.next(true);
    } else {
      resolver.redirectUntil(const AuthRoute());
    }
  }
}
