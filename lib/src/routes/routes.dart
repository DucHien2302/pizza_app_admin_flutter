import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin/src/blocs/authentication_bloc/authentication_bloc.dart';
import '../modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/base/views/base_screen.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/splash/views/splash_screen.dart';

// Create unique keys for each navigator
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

GoRouter router(AuthenticationBloc authBloc) {
  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      redirect: (context, state) {
        if (authBloc.state.status == AuthenticationStatus.unknown) {
          return '/';
        }
        return null; // Important: return null if no redirect is needed
      },
      routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              if (state.fullPath == '/login' || state.fullPath == '/') {
                return child;
              } else {
                return BlocProvider<SignInBloc>(
                    create: (context) => SignInBloc(
                        context.read<AuthenticationBloc>().userRepository),
                    child: BaseScreen(child));
              }
            },
            routes: [
              GoRoute(
                path: "/",
                builder: (context, state) =>
                    BlocProvider<AuthenticationBloc>.value(
                  value: BlocProvider.of<AuthenticationBloc>(context),
                  child: const SplashScreen(),
                ),
              ),
              GoRoute(
                path: "/login",
                builder: (context, state) =>
                    BlocProvider<AuthenticationBloc>.value(
                  value: BlocProvider.of<AuthenticationBloc>(context),
                  child: BlocProvider<SignInBloc>(
                    create: (context) => SignInBloc(
                      context.read<AuthenticationBloc>().userRepository,
                    ),
                    child: const SignInScreen(),
                  ),
                ),
              ),
              GoRoute(
                path: "/home",
                builder: (context, state) =>
                    BlocProvider<AuthenticationBloc>.value(
                  value: BlocProvider.of<AuthenticationBloc>(context),
                  child: const HomeScreen(),
                ),
              ),
            ])
      ]);
}
