import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_progress_indicator.dart';
import 'snackbar.dart';

class CommentPopup extends StatelessWidget {
  const CommentPopup({
    Key? key,
    required this.commentContentController,
    required this.comments,
    required this.postID,
    required this.context,
  }) : super(key: key);

  final TextEditingController commentContentController;
  final List<Comment> comments;
  final BuildContext context;
  final String postID;

  @override
  Widget build(BuildContext context) {
    /////////////alertDialog//////////

    AlertDialog commentDialog = AlertDialog(
      backgroundColor: Colors.blue.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Create a new Comment'),
      content: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: commentContentController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter comment content.'),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            commentContentController.text = '';
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Save',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            Comment newComment = new Comment(commentContentController.text,
                DateTime.now(), 'user123', postID);

            Map data = {
              'comment': newComment.comment,
              'created': newComment.created,
              'user': newComment.userName,
              'postID': newComment.postID
            };

            Backendless.data.of("Comments").save(data).then((value) {
              commentContentController.text = '';

              AppProgressIndicator(text: 'Creating Comment');
              showSnackBar(context, 'Comment Created');
            });
          },
        ),
      ],
    );
    return (commentDialog);
  }
}
