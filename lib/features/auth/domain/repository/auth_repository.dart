import 'package:bloggers_hub/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
  Future<Either<Failure,String>> signInWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
   Future<Either<Failure,String>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}