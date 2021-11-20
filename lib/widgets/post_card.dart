import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostCard extends StatelessWidget {
  const PostCard(
      {Key? key,
      required this.postTitle,
      required this.postText,
      required this.containsImage,
      required this.dateTime})
      : super(key: key);

  final postTitle;
  final postText;
  final bool containsImage;
  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: Colors.lightBlue,
        title: Text("$postTitle"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$postText"),
            Text("$dateTime"),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
