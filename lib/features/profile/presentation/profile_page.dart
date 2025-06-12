import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/widgets/loader.dart';
import '../../../common/presentation/widgets/snack_bar.dart';
import '../../../core/di/locator.dart';
import '../../../core/routing/app_router.dart';
import '../domain/cubits/profile_cubit.dart';

@RoutePage()
class ProfilePage extends StatelessWidget implements AutoRouteWrapper {
  const ProfilePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ProfileCubit>(),
      child: this,
    );
  }

  void _listener(BuildContext context, ProfileState state) {
    if (state.status.isSuccess) {
      context.replaceRoute(const HomeRoute());
    }
    if (state.status.isError) {
      AppSnackBar.showError(
        context,
        state.errorMessage ?? 'Something went wrong :(',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: _listener,

      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: state.status.isLoading
              ? const Loader()
              : Center(
                  child: Column(
                    spacing: 32,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.person, size: 32),
                        radius: 32,
                      ),
                      Text(state.user?.email ?? ''),
                      ElevatedButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          context.read<ProfileCubit>().logout();
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
