import 'dart:io';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/comment.dart';
import 'package:cut_info/models/post.dart';
import 'package:cut_info/widgets/comment_card.dart';
import 'package:cut_info/widgets/comment_popup.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key, this.objectID}) : super(key: key);

  final String? objectID;

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

    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "postID = '${widget.objectID}'"
      ..pageSize = 100;
    print({widget.objectID});
    Backendless.data.of("Comments").find(queryBuilder).then((tableComments) {
      tableComments!.forEach((element) {
        setState(() {
          Comment comment = new Comment(element?["comment"],
              element?["created"], element?["user"], element?["postID"]);
          comments.add(comment);
          print(element?["comment"]);
        });
      });
      setState(() {
        comments.sort((a, b) => b.created.compareTo(a.created));
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
                sleep(Duration(microseconds: 200));
                DataQueryBuilder queryBuilder = DataQueryBuilder()
                  ..whereClause = "postID = '${widget.objectID}'"
                  ..pageSize = 100;
                comments.clear();
                Backendless.data
                    .of("Comments")
                    .find(queryBuilder)
                    .then((tableComments) {
                  tableComments!.forEach((element) {
                    setState(() {
                      Comment comment = new Comment(
                          element?["comment"],
                          element?["created"],
                          element?["user"],
                          element?["postID"]);
                      comments.add(comment);
                      print(element?["comment"]);
                    });
                  });
                  setState(() {
                    comments.sort((a, b) => b.created.compareTo(a.created));
                  });
                });
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue.shade700,
                          Colors.lightBlue.shade50
                        ],
                      ),
                    ),
                    child: Row(
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
                                            color: Colors.black, width: 3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
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
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7))),
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
                                              child:
                                                  Text(post.created.toString()),
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
          ],
        ));
  }
}
