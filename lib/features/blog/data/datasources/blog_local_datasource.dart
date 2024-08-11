import 'package:bloggers_hub/features/blog/data/models/blog_model.dart';
import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDatasource {
  void cacheBlogs(List<BlogModel> blogs);
  List<BlogModel> getCachedBlogs();
}

class BlogLocalDatasourceImpl implements BlogLocalDatasource {
  final Box box;
  BlogLocalDatasourceImpl(this.box);
  @override
  void cacheBlogs(List<BlogModel> blogs) {
    box.clear();

    for (int i = 0; i < blogs.length; i++) {
      box.put('$i', (blogs[i]).toJson());
    }
    print(box.toString());
  }

  @override
  List<BlogModel> getCachedBlogs() {
    List<BlogModel> blogs = [];

    for (int i = 0; i < box.length; i++) {
      Map<String, dynamic> json = Map<String, dynamic>.from(box.get('$i'));
      blogs.add(BlogModel.fromJson(json));
    }
    print(blogs[1].title);

    return blogs;
  }
}
