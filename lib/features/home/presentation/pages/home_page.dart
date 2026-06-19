import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/core/di/injection.dart';
import 'package:flutter_clean_architecture_bloc/core/extentions/context_extension.dart';
import 'package:flutter_clean_architecture_bloc/features/home/presentation/bloc/user/user_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/home/presentation/bloc/user/user_event.dart';

import '../bloc/user/user_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>()..add(UserEvent.loadCurrentUser()),
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        state.mapOrNull(
          error: (failure) => context.showErrorSnackBar(failure.message),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => state.maybeWhen(
              orElse: () => Text("Welcome"),
              loaded: (user, _) => Text("Welcome ${user.name}"),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context.read<UserBloc>().add(UserEvent.logout()),
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
