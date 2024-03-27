import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/feature/auth/view/login_view.dart';
import 'package:state_management_test/feature/auth/view/signup_view.dart';
import 'package:state_management_test/feature/home/view/home_view.dart';

final _key = GlobalKey<NavigatorState>();

enum AppRoute {login,home,signup}

final routerProvider = Provider<GoRouter>((ref) {

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: '/${AppRoute.login.name}',
    routes:
    [
      GoRoute(
        path: '/${AppRoute.login.name}',
        name: AppRoute.login.name,
        builder: (context, state)
        {
          return const LoginView();
        },
      ),
      GoRoute(
        path: '/${AppRoute.signup.name}',
        name: AppRoute.signup.name,
        builder: (context, state)
        {
          return const SignUpView();
        },
      ),
      GoRoute(
        path: '/${AppRoute.home.name}',
        name: AppRoute.home.name,
        builder: (context, state)
        {
          return const HomeView();
        },
      ),
    ],
  );
},
);