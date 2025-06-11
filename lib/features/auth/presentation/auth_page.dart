import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/widgets/loader.dart';
import '../../../common/presentation/widgets/snack_bar.dart';
import '../../../core/di/locator.dart';
import '../../../core/routing/app_router.dart';
import '../../../theme/theme_ext.dart';
import '../domain/cubit/auth_cubit.dart';

const _demoName = 'test@user.br';
const _demoPass = '1234567890';

@RoutePage()
class AuthPage extends StatefulWidget implements AutoRouteWrapper {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => locator<AuthCubit>(), child: this);
  }
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController(text: _demoName);
  final _passwordController = TextEditingController(text: _demoPass);
  bool _isLogin = true;
  AuthCubit get _cubit => context.read<AuthCubit>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text;
    final password = _passwordController.text;

    _isLogin ? _cubit.login(email, password) : _cubit.register(email, password);
  }

  void _listener(BuildContext context, AuthState state) {
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _listener,
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _isLogin ? 'Welcome Back!' : 'Create Account',
                  style: context.styles.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                state.status.isLoading
                    ? const Loader()
                    : ElevatedButton(
                        onPressed: _submit,
                        child: Text(_isLogin ? 'Login' : 'Register'),
                      ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? 'Don\'t have an account? Register'
                        : 'Already have an account? Login',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
