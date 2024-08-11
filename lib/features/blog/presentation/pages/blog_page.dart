import 'package:bloggers_hub/core/common/utils/snackbar.dart';
import 'package:bloggers_hub/core/common/widgets/loader.dart';
import 'package:bloggers_hub/features/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:bloggers_hub/features/blog/presentation/pages/add_bloc_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
    super.initState();
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogDisplaySuccess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.blogs[index].title),
                    subtitle: Text(state.blogs[index].content),
                  );
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
