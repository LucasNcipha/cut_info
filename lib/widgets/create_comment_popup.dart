import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/comment.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'app_progress_indicator.dart';
import 'snackbar.dart';

class CommentPopup extends StatelessWidget {
  const CommentPopup({
    Key? key,
    required this.commentContentController,
    required this.postID,
    required this.context,
  }) : super(key: key);

  final TextEditingController commentContentController;

  final BuildContext context;
  final String postID;

  @override
  Widget build(BuildContext context) {
    /////////////alertDialog//////////

    AlertDialog commentDialog = AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.only(top: 150, bottom: 250),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Create a new Comment'),
      content: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: 300,
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
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          onPressed: () {
            commentContentController.text = '';
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Save',
            style: TextStyle(color: Colors.lightBlue.shade400, fontSize: 18),
          ),
          onPressed: () async {
            Navigator.of(context).pop();

            String userName = getUsername();

            Comment newComment = new Comment(commentContentController.text,
                DateTime.now(), userName, postID);

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
