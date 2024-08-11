import 'dart:io';

import 'package:bloggers_hub/core/common/cubits/auth_user/auth_user_cubit.dart';
import 'package:bloggers_hub/core/common/utils/pickimage.dart';
import 'package:bloggers_hub/core/common/utils/snackbar.dart';
import 'package:bloggers_hub/core/common/widgets/loader.dart';
import 'package:bloggers_hub/core/theme/app_pallete.dart';
import 'package:bloggers_hub/features/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:bloggers_hub/features/blog/presentation/pages/blog_page.dart';
import 'package:bloggers_hub/features/blog/presentation/widgets/blog_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlocPage extends StatefulWidget {
  const AddBlocPage({super.key});
  static route() =>
      MaterialPageRoute(builder: (context) => const AddBlocPage());

  @override
  State<AddBlocPage> createState() => _AddBlocPageState();
}

class _AddBlocPageState extends State<AddBlocPage> {
  List<String> selectedTopics = [];
  File? image;
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    void uploadBlog() {
      if (formKey.currentState!.validate() &&
          image != null &&
          selectedTopics.isNotEmpty) {
        final posterId =
            (context.read<AuthUserCubit>().state as AuthUserLoggedIn).user.id;
        context.read<BlogBloc>().add(BlogUpload(titleController.text.trim(),
            contentController.text.trim(), image!, selectedTopics, posterId));
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.done_rounded),
              onPressed: () {
                uploadBlog();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<BlogBloc, BlogState>(
            listener: (context, state) {
              if (state is BlogFailure) {
                showSnackbar(context, state.message);
              }
              if (state is BlogSuccess) {
                showSnackbar(context, "Blog Uploaded Successfully");
                Navigator.pushAndRemoveUntil(
                    context, BlogPage.route(), (route) => false);
              }
            },
            builder: (context, state) {
              if (state is BlogLoading) {
                return const Loader();
              }
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            )
                          : DottedBorder(
                              color: Pallete.borderColor,
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_open_rounded, size: 40),
                                    SizedBox(height: 10),
                                    Text(
                                      "Select your Image",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <String>[
                          "Technology",
                          "Health",
                          "Business",
                          "Entertainment",
                          "Sports",
                          "Science",
                          "Politics",
                          "Education",
                          "Fashion",
                          "Travel",
                          "Food",
                          "Lifestyle",
                          "Programming",
                          "Engineering",
                          "Design",
                          "Art",
                          "Music",
                          "Movies",
                          "Books",
                        ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedTopics.contains(e)) {
                                      selectedTopics.remove(e);
                                    } else {
                                      selectedTopics.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    color: selectedTopics.contains(e)
                                        ? const WidgetStatePropertyAll(
                                            Pallete.gradient1)
                                        : null,
                                    side: selectedTopics.contains(e)
                                        ? null
                                        : const BorderSide(
                                            color: Pallete.borderColor,
                                          ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlogTextfield(
                        hintText: "Blog Title", controller: titleController),
                    const SizedBox(
                      height: 20,
                    ),
                    BlogTextfield(
                        hintText: "Blog Description",
                        controller: contentController),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
