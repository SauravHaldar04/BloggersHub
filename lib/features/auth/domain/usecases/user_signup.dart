import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/core/usecase/usecase.dart';
import 'package:bloggers_hub/core/entities/user_entity.dart';
import 'package:bloggers_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignup implements Usecase<User, UserSignupParams> {
  final AuthRepository authRepository;
  const UserSignup(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.signInWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;

  UserSignupParams(
      {required this.name, required this.email, required this.password});

}
