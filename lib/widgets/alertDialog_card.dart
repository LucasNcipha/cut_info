import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_progress_indicator.dart';
import 'dialogs.dart';

class AlertDialogCard extends StatelessWidget {
  const AlertDialogCard({
    Key? key,
    required this.postTitleController,
    required this.postContentController,
    required this.posts,
    required this.context,
  }) : super(key: key);

  final TextEditingController postTitleController;
  final TextEditingController postContentController;
  final List<Posts> posts;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    /////////////alertDialog//////////
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.blue.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Create a new Post'),
      content: Column(
        children: [
          TextField(
            keyboardType: TextInputType.text,
            controller: postTitleController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter Post Title.'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: postContentController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Post content.'),
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
            postTitleController.text = '';
            postContentController.text = '';
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Save',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () async {
            Posts newPost = new Posts(postTitleController.text,
                postContentController.text, false, DateTime.now());

            Map data = {
              'title': newPost.title,
              'content': newPost.content,
              'hasImage': newPost.hasImage,
              'created': newPost.created
            };

            Backendless.data.of("General").save(data).then((value) {
              postTitleController.text = '';
              postContentController.text = '';
              Navigator.of(context).pop();

              AppProgressIndicator(text: 'Creating Post');
              showSnackBar(context, 'Post Created');
            });
            //Backendless.data.withClass<Posts>().save(newPost);
          },
        ),
      ],
    );
    return (alertDialog);
  }
}
