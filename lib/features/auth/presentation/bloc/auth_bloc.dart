import 'package:bloc/bloc.dart';
import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/features/auth/domain/entities/user_entity.dart';
import 'package:bloggers_hub/features/auth/domain/usecases/user_login.dart';
import 'package:bloggers_hub/features/auth/domain/usecases/user_signup.dart';
import 'package:meta/meta.dart';
import 'package:fpdart/fpdart.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;

  AuthBloc({required UserSignup userSignup, required UserLogin userLogin})
      : _userSignup = userSignup,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
  }
  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userSignup(UserSignupParams(
        email: event.email, password: event.password, name: event.name));
    result.fold((failure) {
      emit(AuthFailure(failure.message));
    }, (user) {
      emit(AuthSuccess(user));
    });
  }

  void _onAuthLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    result.fold((failure) {
      emit(AuthFailure(failure.message));
    }, (user) {
      emit(AuthSuccess(user));
    });
  }
}
