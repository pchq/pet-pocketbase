import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/routing/app_router.dart';

enum _HomeTab {
  tasks,
  profile;

  PageRouteInfo get route => switch (this) {
    _HomeTab.tasks => const TasksRoute(),
    _HomeTab.profile => const ProfileRoute(),
  };

  Icon get icon => switch (this) {
    _HomeTab.tasks => const Icon(Icons.task_alt),
    _HomeTab.profile => const Icon(Icons.account_circle_outlined),
  };
  String get label => switch (this) {
    _HomeTab.tasks => 'Tasks',
    _HomeTab.profile => 'Profile',
  };
}

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 3,
      routes: _HomeTab.values.map((tab) => tab.route).toList(),
      transitionBuilder: (context, child, animation) =>
          FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: _HomeTab.values
                .map(
                  (item) => BottomNavigationBarItem(
                    icon: item.icon,
                    label: item.label,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
