import 'package:bloc/bloc.dart';
import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/features/auth/domain/entities/user_entity.dart';
import 'package:bloggers_hub/features/auth/domain/usecases/user_signup.dart';
import 'package:meta/meta.dart';
import 'package:fpdart/fpdart.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;

  AuthBloc({required UserSignup userSignup})
      : _userSignup = userSignup,
        super(AuthInitial()) {
    onChange(change) {
      print(change);
    }

    on<AuthSignUp>((event, emit) async {
      final result = await _userSignup(UserSignupParams(
          email: event.email, password: event.password, name: event.name));
      result.fold((failure) {
        emit(AuthFailure(failure.message));
      }, (user) {
        emit(AuthSuccess(user));
      });
    });
  }
}
