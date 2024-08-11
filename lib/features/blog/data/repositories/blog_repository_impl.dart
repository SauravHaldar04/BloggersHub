import 'dart:io';

import 'package:bloggers_hub/core/common/network/check_internet_connection.dart';
import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/core/error/server_exception.dart';
import 'package:bloggers_hub/features/blog/data/datasources/blog_local_datasource.dart';
import 'package:bloggers_hub/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:bloggers_hub/features/blog/data/models/blog_model.dart';
import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';
import 'package:bloggers_hub/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  BlogRemoteDatasource blogRemoteDatasource;
  BlogLocalDatasource blogLocalDatasource;
  CheckInternetConnection checkInternetConnection;
  BlogRepositoryImpl(this.blogRemoteDatasource, this.blogLocalDatasource,
      this.checkInternetConnection);
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required String title,
      required String content,
      required String posterId,
      required List<String> topics,
      required File image}) async {
    try {
      if (await checkInternetConnection.isConnected == false) {
        return Left(Failure('No internet connection'));
      }
      final blog = BlogModel(
          id: const Uuid().v1(),
          title: title,
          content: content,
          imageUrl: '',
          posterId: posterId,
          updatedAt: DateTime.now(),
          topics: topics);
      final imageUrl = await blogRemoteDatasource.uploadBlogImage(blog, image);
      final blogWithImageUrl = blog.copyWith(
        imageUrl: imageUrl,
      );
      final blogModel = await blogRemoteDatasource.uploadBlog(blogWithImageUrl);
      return Right(blogModel);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (await checkInternetConnection.isConnected == false) {
        return Right(blogLocalDatasource.getCachedBlogs());
      }
      final blogModels = await blogRemoteDatasource.getAllBlogs().then((value) {
        blogLocalDatasource.cacheBlogs(value);
        return value;
      });
      print(blogModels[0].posterName);

      return Right(blogModels);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
