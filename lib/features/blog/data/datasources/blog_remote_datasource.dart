import 'dart:io';

import 'package:bloggers_hub/core/error/server_exception.dart';
import 'package:bloggers_hub/features/blog/data/models/blog_model.dart';
import 'package:flutter/rendering.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDatasource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage(BlogModel blog, File image);
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDatasourceImpl implements BlogRemoteDatasource {
  final SupabaseClient client;
  BlogRemoteDatasourceImpl(this.client);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await client.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(BlogModel blog, File image) async {
    try {
      await client.storage.from('blog_images').upload(blog.id, image);
      return client.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogData = await client.from('blogs').select('*,profiles(name)');
      return blogData
          .map((blog) => BlogModel.fromJson(blog)
              .copyWith(posterName: blog['profiles']['name']))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
