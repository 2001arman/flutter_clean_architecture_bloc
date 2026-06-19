import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/core/di/injection.dart';
import 'package:flutter_clean_architecture_bloc/core/extentions/context_extension.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/bloc/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.mapOrNull(
          failure: (failure) => context.showErrorSnackBar(failure.message),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome Home Page"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthEvent.logout());
              },
              icon: Icon(Icons.logout),
              color: Colors.red,
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: Center(child: Text("Home Page Bosque")),
      ),
    );
  }
}
