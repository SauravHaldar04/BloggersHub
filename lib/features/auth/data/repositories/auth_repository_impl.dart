import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/core/error/server_exception.dart';
import 'package:bloggers_hub/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:bloggers_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository{
 final AuthRemoteDatasources authRemoteDatasources;
  const AuthRepositoryImpl(this.authRemoteDatasources);
  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword({required String name, required String email, required String password})async {
    try{
      final userId = await authRemoteDatasources.signInWithEmailAndPassword(name: name, email: email, password: password);
      return Right(userId);
    }
    on ServerException catch(e){
      return Left(Failure(e.message));
    }
  }

}