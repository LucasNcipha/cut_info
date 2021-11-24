import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/post.dart';
import 'package:cut_info/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';

submitPost(TextEditingController postTitleController,
    TextEditingController postContentController) {
  AppProgressIndicator(text: 'Creating Post');

  Posts newPost = new Posts(postTitleController.text,
      postContentController.text, false, DateTime.now());

  postTitleController.text = '';
  postContentController.text = '';

  Map data = {
    'title': newPost.title,
    'content': newPost.content,
    'hasImage': newPost.hasImage,
    'created': newPost.created
  };

  Backendless.data.of("General").save(data);
}
