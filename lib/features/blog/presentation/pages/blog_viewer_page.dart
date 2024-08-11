import 'package:bloggers_hub/core/common/utils/calculate_reading_time.dart';
import 'package:bloggers_hub/core/common/utils/format_date.dart';
import 'package:bloggers_hub/core/theme/app_pallete.dart';
import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(blog.title,
                  style:
                      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 15,
              ),
              Text('Posted by ${blog.posterName!}',
                  style:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 7,
              ),
              Text(
                  '${formatDatedMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min read',
                  style: const TextStyle(fontSize: 12, color: Pallete.greyColor)),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  blog.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                blog.content,
                style: const TextStyle(fontSize: 16, height: 2),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
