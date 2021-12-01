import 'package:cut_info/models/comment.dart';
import 'package:cut_info/models/post.dart';
import 'package:cut_info/services/helper_comment.dart';
import 'package:cut_info/widgets/comment_card.dart';
import 'package:cut_info/widgets/create_comment_popup.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key, this.objectID}) : super(key: key);

  final String? objectID;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late TextEditingController postCommentController;

  List<Comment> comments = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    postCommentController = TextEditingController();

    recieveComments(widget.objectID).then((value) {
      setState(() {
        comments = value;
      });
    });
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
          backgroundColor: Colors.blue.shade700,
          title: Text('Post'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.comment),
              tooltip: 'Make a comment',
              onPressed: () async {
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CommentPopup(
                        commentContentController: postCommentController,
                        comments: comments,
                        context: context,
                        postID: post.objectId);
                  },
                );

                recieveComments(widget.objectID).then((value) {
                  setState(() {
                    comments = value;
                  });
                });
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade700, Colors.lightBlue.shade50],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlue.shade400,
                                          border: Border.all(
                                              color: Colors.black45,
                                              width: 1.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 20,
                                                left: 5,
                                                right: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white70),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6,
                                                    bottom: 6,
                                                    left: 25,
                                                    right: 25),
                                                child: Expanded(
                                                  child: Text(
                                                    post.title,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(post.content,
                                                style: TextStyle(fontSize: 16)),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    post.created.toString()),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return CommentCard(
                                userName: comments[index].userName,
                                dateAndTime: comments[index].created,
                                commentText: comments[index].comment);
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
