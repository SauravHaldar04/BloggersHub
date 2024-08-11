

import 'dart:io';

import 'package:bloggers_hub/core/error/failure.dart';
import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
    required File image
  });
  }