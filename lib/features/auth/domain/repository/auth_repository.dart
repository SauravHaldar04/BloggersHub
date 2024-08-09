import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/features/auth/data/models/user_model.dart';
import 'package:bloggers_hub/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
  Future<Either<Failure,User>> signInWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
   Future<Either<Failure,User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}