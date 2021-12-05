import 'dart:io';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/comment.dart';
import 'package:cut_info/services/user_service.dart';

Future<List<Comment>> recieveComments(String? objectID) async {
  sleep(Duration(microseconds: 200));
  List<Comment> comments = List.empty(growable: true);

  DataQueryBuilder queryBuilder = DataQueryBuilder()
    ..whereClause = "postID = '$objectID'"
    ..pageSize = 100;

  await Backendless.data
      .of("Comments")
      .find(queryBuilder)
      .then((tableComments) {
    tableComments!.forEach((element) {
      Comment comment = new Comment(element?["comment"], element?["created"],
          element?["user"], element?["postID"]);
      comments.add(comment);
    });

    comments.sort((a, b) => b.created.compareTo(a.created));
  });

  return comments;
}

Future<void> submitComment(String commentContent, String postID) async {
  String userName = getUsername();

  Comment newComment =
      new Comment(commentContent, DateTime.now(), userName, postID);

  Map data = {
    'comment': newComment.comment,
    'created': newComment.created,
    'user': newComment.userName,
    'postID': newComment.postID
  };

  await Backendless.data.of("Comments").save(data);
}
