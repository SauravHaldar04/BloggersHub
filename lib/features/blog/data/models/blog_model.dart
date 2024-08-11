import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.posterId,
      required super.updatedAt,
      required super.topics,
      super.posterName
      });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'poster_id': posterId,
      'updated_at': updatedAt.toIso8601String(),
      'topics': topics,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
        id: map['id'] as String,
        title: map['title'] as String,
        content: map['content'] as String,
        imageUrl: map['image_url'] as String,
        posterId: map['poster_id'] as String,
        updatedAt: map['updated_at'] == null
            ? DateTime.now()
            : DateTime.parse(map['updated_at'] as String),
        topics: map['topics'] == null
            ? []
            : List<String>.from(
                (map['topics']),
              ));
  }

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    String? posterId,
    DateTime? updatedAt,
    List<String>? topics,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      posterId: posterId ?? this.posterId,
      updatedAt: updatedAt ?? this.updatedAt,
      topics: topics ?? this.topics,
      posterName: posterName ?? this.posterName,
    );
  }
}
