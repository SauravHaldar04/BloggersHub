import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/core/error/server_exception.dart';
import 'package:bloggers_hub/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:bloggers_hub/features/auth/data/models/user_model.dart';
import 'package:bloggers_hub/core/entities/user_entity.dart';
import 'package:bloggers_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasources authRemoteDatasources;
  const AuthRepositoryImpl(this.authRemoteDatasources);
  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) {
    return _getUser(() async => await authRemoteDatasources
        .loginWithEmailAndPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String name, required String email, required String password}) {
    return _getUser(() async =>
        await authRemoteDatasources.signInWithEmailAndPassword(
            name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return Right(user);
    } on sb.AuthException catch (e) {
      return Left(Failure(e.message));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, User>> getCurrentUser()async {
    try{
      final user = await authRemoteDatasources.getCurrentUser();
      if(user == null){
        return Left(Failure('User is not logged in'));
      }
      return Right(user);
    }
    on ServerException catch(e){
      return Left(Failure(e.toString()));
    }
  }
}
