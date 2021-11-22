// ignore: unused_import
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/comment.dart';
import 'package:cut_info/models/post.dart';

// ignore: unused_import
import 'package:cut_info/widgets/comment_card.dart';
import 'package:cut_info/widgets/comment_popup.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({
    Key? key,
  }) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late TextEditingController postCommentController;

  final List<Comment> comments = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    postCommentController = TextEditingController();
    /*  Backendless.data.of("Comments").find().then((tableComments) {
      tableComments!.forEach((element) {
        setState(() {
          Comment comment = new Comment(
              element?["Comment"], element?["Created"], element?["UserName"]);
          comments.add(comment);
        });
      });
    }); */
  }

  @override
  void dispose() {
    postCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as Posts;
    return Scaffold(
        appBar: AppBar(
          title: Text('Post'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.comment),
              tooltip: 'Make a comment',
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CommentPopup(
                        commentContentController: postCommentController,
                        comments: comments,
                        context: context);
                  },
                );
              },
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade700, Colors.lightBlue.shade50],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(
                        post.title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(post.content, style: TextStyle(fontSize: 14)),
                    Text(post.created.toString()),
                    /* ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return CommentCard(
                              userName: comments[index].userName,
                              dateAndTime: comments[index].created,
                              commentText: comments[index].comment);
                        }), */
                  ],
                ),
              ],
            )));
  }
}
