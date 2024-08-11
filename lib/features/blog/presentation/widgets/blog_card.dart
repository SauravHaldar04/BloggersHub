import 'package:bloggers_hub/core/common/utils/calculate_reading_time.dart';
import 'package:bloggers_hub/features/blog/domain/entities/blog_entity.dart';
import 'package:bloggers_hub/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  final Color textColor;
  const BlogCard(
      {super.key,
      required this.blog,
      required this.color,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, BlogViewerPage.route(blog)),
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                          label: Text(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${blog.content.substring(0, 100)}...',
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  '${calculateReadingTime(blog.content)} min read',
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Posted by ${blog.posterName}',
                  style: TextStyle(fontSize: 12, color: textColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
