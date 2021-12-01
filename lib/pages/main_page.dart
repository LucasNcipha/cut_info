import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/post.dart';
import 'package:cut_info/services/helper_post.dart';
import 'package:cut_info/services/helper_user.dart';
import 'package:cut_info/widgets/create_post_card_alert_dialog.dart';
import 'package:cut_info/widgets/post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController postTitleController;
  late TextEditingController postContentController;

  List<Posts> posts = List.empty(growable: true);
  DataQueryBuilder queryBuilder = DataQueryBuilder()..pageSize = 100;

  @override
  void initState() {
    super.initState();
    postTitleController = TextEditingController();
    postContentController = TextEditingController();

    recievePosts().then((value) {
      setState(() {
        posts = value;
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
        automaticallyImplyLeading: false,
        title: const Text('Posts'),
        actions: <Widget>[
          //add button
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Make a post',
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CreatePostCard(
                    postTitleController: postTitleController,
                    postContentController: postContentController,
                    context: context,
                  );
                },
              );

              recievePosts().then((value) {
                setState(() {
                  posts = value;
                });
              });
            },
          ), //end add post
          IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                recievePosts().then((value) {
                  setState(() {
                    posts = value;
                  });
                });
              }), //end refresh button
          IconButton(
              icon: Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                logoutUserInUI(context);
              })
        ],
      ),
      body: Container(
        color: Colors.white,
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
                            objectId: posts[index].objectId,
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
