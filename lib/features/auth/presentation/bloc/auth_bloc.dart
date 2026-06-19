import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/usecase/login_use_case.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/bloc/auth_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;

  AuthBloc(this._loginUseCase) : super(AuthState.initial()) {
    on<Login>(_login);
    on<Register>(_register);
    on<Logout>(_logout);
    on<AuthCheck>(_authCheck);
  }

  void _login(Login event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final result = await _loginUseCase.call(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) {
        print('cek dong failure ${failure.toString()}');
        emit(AuthState.failure(failure.message));
      },
      (userEntity) {
        print('cek dong user Entity ${userEntity.toString()}');
        emit(AuthState.authenticated(user: userEntity));
      },
    );
  }

  void _register(Register event, Emitter<AuthState> emit) {}

  void _logout(Logout event, Emitter<AuthState> emit) {}

  void _authCheck(AuthCheck event, Emitter<AuthState> emit) {}
}
