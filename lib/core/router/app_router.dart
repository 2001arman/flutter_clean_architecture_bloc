import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

abstract class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
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
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (isLoggedIn && isOnAuthRoute) return '/home';
      if (!isLoggedIn && !isOnAuthRoute) return '/login';
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
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
