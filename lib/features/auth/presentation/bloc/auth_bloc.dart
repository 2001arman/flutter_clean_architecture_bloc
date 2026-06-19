import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/usecase/login_use_case.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/domain/usecase/register_use_case.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_clean_architecture_bloc/features/auth/presentation/bloc/auth_state.dart';
import 'package:injectable/injectable.dart';

@Injectable(cache: true)
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthBloc(this._loginUseCase, this._registerUseCase)
    : super(AuthState.initial()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<AuthCheck>(_authCheck);
  }

  void _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final result = await _loginUseCase.call(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) {
        emit(AuthState.failure(failure.message));
      },
      (userEntity) {
        emit(AuthState.authenticated(user: userEntity));
      },
    );
  }

  void _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final result = await _registerUseCase.call(
      RegisterParam(
        name: event.fullName,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthState.failure(failure.message)),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  void _authCheck(AuthCheck event, Emitter<AuthState> emit) {}
}
