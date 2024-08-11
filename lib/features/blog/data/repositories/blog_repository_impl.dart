import 'dart:io';

import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/core/error/server_exception.dart';
import 'package:bloggers_hub/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:bloggers_hub/features/blog/data/models/blog_model.dart';
import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';
import 'package:bloggers_hub/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  BlogRemoteDatasource blogRemoteDatasource;
  BlogRepositoryImpl(this.blogRemoteDatasource);
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required String title,
      required String content,
      required String posterId,
      required List<String> topics,
      required File image}) async {
    try {
      final blog = BlogModel(
          id: const Uuid().v1(),
          title: title,
          content: content,
          imageUrl: '',
          posterId: posterId,
          updatedAt: DateTime.now(),
          topics: topics);
      final imageUrl = await blogRemoteDatasource.uploadBlogImage(blog, image);
      final blogWithImageUrl = blog.copyWith(imageUrl: imageUrl);
      final blogModel = await blogRemoteDatasource.uploadBlog(blogWithImageUrl);
      return Right(blogModel);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs()async {
   try{
      final blogModels = await blogRemoteDatasource.getAllBlogs();
      return Right(blogModels);
   }
   on ServerException catch(e){
     return Left(Failure(e.message));
   }
  }
}
