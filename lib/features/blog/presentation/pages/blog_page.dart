import 'package:bloggers_hub/features/blog/presentation/pages/add_bloc_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogPage extends StatelessWidget {
  static route()=>MaterialPageRoute(builder: (_)=>const BlogPage());
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Blog Page",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              icon: const Icon(CupertinoIcons.add_circled),
              onPressed: () {
                Navigator.push(context, AddBlocPage.route());
              })
        ],
      ),
    );
  }
}
