import 'dart:io';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/post.dart';
import 'package:cut_info/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';

Future<void> submitPost(TextEditingController postTitleController,
    TextEditingController postContentController) async {
  AppProgressIndicator(text: 'Creating Post');

  Posts newPost = new Posts(postTitleController.text,
      postContentController.text, false, DateTime.now(), "");

  postTitleController.text = '';
  postContentController.text = '';

  Map data = {
    'title': newPost.title,
    'content': newPost.content,
    'hasImage': newPost.hasImage,
    'created': newPost.created,
    'course': newPost.course
  };

  await Backendless.data.of("General").save(data);
}

Future<List<Posts>> recievePosts() async {
  sleep(Duration(microseconds: 200));
  List<Posts> posts = List.empty(growable: true);
  DataQueryBuilder queryBuilder = DataQueryBuilder()..pageSize = 100;

  await Backendless.data.of("General").find(queryBuilder).then((tablePosts) {
    tablePosts!.forEach((element) {
      Posts post = new Posts(element?["title"], element?["content"],
          element?["hasImage"], element?["created"], element?["objectId"]);
      posts.add(post);
    });
    posts.sort((a, b) => b.created.compareTo(a.created));
  });

  return posts;
}
