import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/core/usecase/usecase.dart';
import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';
import 'package:bloggers_hub/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>,NoParams>{
  final BlogRepository repository;

  GetAllBlogs(this.repository);

  @override
  Future<Either<Failure,List<Blog>>> call(NoParams params) async {
    return await repository.getAllBlogs();
  }
}