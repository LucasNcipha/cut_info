import 'dart:io';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/comment.dart';

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
