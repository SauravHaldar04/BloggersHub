import 'dart:io';

import 'package:bloggers_hub/core/usecase/usecase.dart';
import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';
import 'package:bloggers_hub/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:bloggers_hub/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  UploadBlog _uploadBlog;
  GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _getAllBlogs = getAllBlogs,
        _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onBlogFetchAllBlogs);
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
        posterId: event.posterId));
    res.fold((l) {
      emit(BlogFailure(l.message));
      print(l.message);
    }, (r) => emit(BlogUploadSuccess()));
  }

  void _onBlogFetchAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    await _getAllBlogs(NoParams()).then((res) {
      res.fold((l) {
        emit(BlogFailure(l.message));
        print(l.message);
      }, (r) => emit(BlogDisplaySuccess(r)));
    });
  }
}
