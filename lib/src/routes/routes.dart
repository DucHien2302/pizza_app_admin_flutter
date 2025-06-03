import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin/src/blocs/authentication_bloc/authentication_bloc.dart';
import '../modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/base/views/base_screen.dart';
import '../modules/create_pizza/views/create_pizza_screen.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/splash/views/splash_screen.dart';

// Create a custom Listenable for GoRouter
class AuthenticationRefreshNotifier extends ChangeNotifier {
  final AuthenticationBloc authBloc;
  late final StreamSubscription _subscription;

  AuthenticationRefreshNotifier(this.authBloc) {
    _subscription = authBloc.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// Create a single global instance of the navigation keys
// This prevents duplicate keys being created when the router is regenerated
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

GoRouter router(AuthenticationBloc authBloc) {
  final refreshNotifier = AuthenticationRefreshNotifier(authBloc);
  return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: refreshNotifier,
      redirect: (context, state) {
        final currentLocation = state.fullPath;
        
        if (authBloc.state.status == AuthenticationStatus.unknown) {
          return '/';
        } 
        else if (authBloc.state.status == AuthenticationStatus.authenticated && 
                (currentLocation == '/' || currentLocation == '/login')) {
          return '/home';
        }
        else if (authBloc.state.status == AuthenticationStatus.unauthenticated && 
                 currentLocation != '/login') {
          return '/login';
        }
        return null;
      },      
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: BlocProvider<AuthenticationBloc>.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: const SplashScreen(),
            ),
          ),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: BlocProvider<AuthenticationBloc>.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: BlocProvider<SignInBloc>(
                create: (context) => SignInBloc(context
                    .read<AuthenticationBloc>()
                    .userRepository),
                child: const SignInScreen(),
              ),
            ),
          ),
        ),
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return BlocProvider.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: BlocProvider(
                create: (context) => SignInBloc(context
                    .read<AuthenticationBloc>()
                    .userRepository),
                child: BaseScreen(child)
              ),
            );
          },
          routes: [            
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const HomeScreen(),
              ),
            ),
            GoRoute(
              path: '/create',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const CreatePizzaScreen(),
              ),
            ),
          ],
        ),
      ],
      errorPageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text('Error: ${state.error}'),
          ),
        ),
      ),
    );
}
