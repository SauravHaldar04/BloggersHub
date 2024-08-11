part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class BlogUpload extends BlogEvent {
  final String title;
  final String content;
  final File image;
  final List<String> topics;
  final String posterId;
  BlogUpload(this.title, this.content, this.image, this.topics, this.posterId);
}
