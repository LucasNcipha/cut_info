import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/post.dart';
// ignore: unused_import
import 'package:cut_info/services/helper_todo.dart';
// ignore: unused_import
import 'package:cut_info/services/user_service.dart';
import 'package:cut_info/widgets/app_progress_indicator.dart';
// ignore: unused_import
import 'package:cut_info/widgets/app_textfield.dart';
import 'package:cut_info/widgets/dialogs.dart';
import 'package:cut_info/widgets/post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:tuple/tuple.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController postTitleController;
  late TextEditingController postContentController;

  final List<Posts> posts = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    postTitleController = TextEditingController();
    postContentController = TextEditingController();
    Backendless.data.of("General").find().then((tablePosts) {
      tablePosts!.forEach((element) {
        setState(() {
          Posts post = new Posts(element?["title"], element?["content"],
              element?["hasImage"], element?["created"]);
          posts.add(post);
        });

        print("title ${posts[0].title}");
        print("content ${posts[0].content}");
        print("hasImage ${posts[0].hasImage}");
        print("created ${posts[0].created}");
      });
    });
  }

  @override
  void dispose() {
    postTitleController.dispose();
    postContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /////////////alertDialog//////////
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.blue,
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
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: postContentController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter Post content.'),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Demo'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Show Snackbar',
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return alertDialog;
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
        child: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostCard(
                            postTitle: posts[index].title,
                            postText: posts[index].content,
                            containsImage: posts[index].hasImage,
                            dateTime: posts[index].created,
                          );
                        }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
