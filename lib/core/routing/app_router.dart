import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/presentation/auth_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/profile/presentation/profile_page.dart';
import '../../features/tasks/presentation/tasks_page.dart';
import '../di/locator.dart';
import 'guards/auth_guard.dart';
part 'app_router.gr.dart';

abstract class AppRoute {
  static const auth = '/auth';
  static const home = '/home';
  static const tasks = 'tasks';
  static const profile = 'profile';
}

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Page|Tab,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final routes = [
    AutoRoute(page: AuthRoute.page, path: AppRoute.auth),
    AutoRoute(
      page: HomeRoute.page,
      path: AppRoute.home,
      initial: true,
      guards: [locator<AuthGuard>()],
      children: [
        AutoRoute(page: TasksRoute.page, path: AppRoute.tasks),
        AutoRoute(page: ProfileRoute.page, path: AppRoute.profile),
      ],
    ),
  ];
}
