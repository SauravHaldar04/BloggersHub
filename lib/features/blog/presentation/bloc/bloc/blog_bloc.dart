import 'dart:io';
import 'dart:math';

import 'package:bloggers_hub/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  UploadBlog uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await uploadBlog(UploadBlogParams(
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
        posterId: event.posterId));
    res.fold((l) {
      emit(BlogFailure(l.message));
      print(l.message);
    }, (r) => emit(BlogSuccess()));
  }
}
