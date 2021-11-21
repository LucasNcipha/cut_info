import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/post.dart';
// ignore: unused_import
import 'package:cut_info/services/helper_todo.dart';
import 'package:cut_info/services/helper_user.dart';
// ignore: unused_import
import 'package:cut_info/services/user_service.dart';
import 'package:cut_info/widgets/alertDialog_card.dart';
// ignore: unused_import
import 'package:cut_info/widgets/app_textfield.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Make a post',
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return alertDialogCard(
                      postTitleController: postTitleController,
                      postContentController: postContentController,
                      posts: posts,
                      context: context);
                },
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                Backendless.data.of("General").find().then((tablePosts) {
                  tablePosts!.forEach((element) {
                    setState(() {});
                  });
                });
              }),
          IconButton(
              icon: Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                logoutUserInUI(context);
              })
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
