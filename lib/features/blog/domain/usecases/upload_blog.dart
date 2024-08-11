
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:bloggers_hub/core/usecase/usecase.dart';
import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';
import 'package:bloggers_hub/features/blog/domain/repositories/blog_repository.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository repository;

  UploadBlog(this.repository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await repository.uploadBlog(
        title: params.title,
        content: params.content,
        image: params.image,
        posterId: params.posterId,
        topics: params.topics);
  }
}

class UseCase {
}

class UploadBlogParams {
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  final File image;
  UploadBlogParams({
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
    required this.image,
  });
}
