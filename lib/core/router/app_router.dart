import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_clean_architecture_bloc/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

abstract class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
}

@lazySingleton
class AppRouter {
  final FirebaseAuth _firebaseAuth;

  AppRouter(this._firebaseAuth);

  GoRouter get router => GoRouter(
    initialLocation: Routes.login,
    refreshListenable: GoRouterRefreshStream(_firebaseAuth.authStateChanges()),
    redirect: (context, state) {
      final isLoggedIn = _firebaseAuth.currentUser != null;
      final isOnAuthRoute =
          state.matchedLocation == Routes.login ||
          state.matchedLocation == Routes.register;

      if (isLoggedIn && isOnAuthRoute) return Routes.home;
      if (!isLoggedIn && !isOnAuthRoute) return Routes.login;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
