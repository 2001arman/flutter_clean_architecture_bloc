import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/contacts/presentation/pages/contact_page.dart';
import '../../features/home/presentation/bloc/chat_room/chat_room_bloc.dart';
import '../../features/home/presentation/bloc/chat_room/chat_room_event.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../di/injection.dart';

abstract class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const contact = '/contact';
}

@lazySingleton
class AppRouter {
  final FirebaseAuth _firebaseAuth;
  late final GoRouter router;

  AppRouter(this._firebaseAuth) {
    router = GoRouter(
      initialLocation: Routes.login,
      refreshListenable: GoRouterRefreshStream(
        _firebaseAuth.authStateChanges(),
      ),
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

        ShellRoute(
          builder: (context, state, child) => BlocProvider(
            create: (context) =>
                getIt<ChatRoomBloc>()..add(ChatRoomEvent.loadRooms()),
            child: child,
          ),
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: Routes.contact,
              builder: (context, state) => const ContactPage(),
            ),
          ],
        ),
      ],
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((_) => notifyListeners());
  }
}
