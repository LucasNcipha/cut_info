import 'package:cut_info/models/post.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Posts post;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Post'),
          actions: <Widget>[],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade700, Colors.lightBlue.shade50],
            ),
          ),
        ));
  }
}
