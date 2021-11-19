import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.postTitle,
    required this.postText,
    required this.containsImage,
  }) : super(key: key);

  final postTitle;
  final postText;
  final bool containsImage;

  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        tileColor: Colors.lightBlue,
        title: Text('Three-line ListTile'),
        subtitle: Text(
            'A sufficiently long subtitle warrants three lines.'
        ),

        isThreeLine: true,
      ),


    );
  }
}
