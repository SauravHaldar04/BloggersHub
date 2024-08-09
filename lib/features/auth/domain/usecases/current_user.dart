import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/core/usecase/usecase.dart';
import 'package:bloggers_hub/features/auth/domain/entities/user_entity.dart';
import 'package:bloggers_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User,NoParams>{
  final AuthRepository repository;

  CurrentUser(this.repository);

  @override
  Future<Either<Failure,User>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}