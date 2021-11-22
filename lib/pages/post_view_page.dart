import 'package:cut_info/models/post.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({
    Key? key,
  }) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as Posts;
    return Scaffold(
        appBar: AppBar(
          title: Text(post.title),
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
