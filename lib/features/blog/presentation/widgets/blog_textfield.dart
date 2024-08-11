import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const BlogTextfield(
      {super.key, required this.hintText, required this.controller});

  @override
  State<BlogTextfield> createState() => _BlogTextfieldState();
}

class _BlogTextfieldState extends State<BlogTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      maxLines: null,
    );
  }
}
