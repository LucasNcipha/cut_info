import 'package:cut_info/models/post.dart';
import 'package:cut_info/services/helper_post.dart';
import 'package:cut_info/services/helper_user.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:cut_info/widgets/app_progress_indicator.dart';
import 'package:cut_info/widgets/create_post_card_alert_dialog.dart';
import 'package:cut_info/widgets/post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController postTitleController;
  late TextEditingController postContentController;

  List<Posts> posts = List.empty(growable: true);

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
          Padding(
            padding: const EdgeInsets.only(right: 100),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.manage_accounts),
              splashColor: Colors.purple,
              splashRadius: 50,
              tooltip: 'Manage Posts',
            ),
          ) //add button
          ,
          IconButton(
            icon: const Icon(Icons.add),
            splashColor: Colors.purple,
            splashRadius: 50,
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
              splashColor: Colors.purple,
              splashRadius: 50,
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
              splashColor: Colors.purple,
              splashRadius: 50,
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
                          String postText = posts[index].content;
                          postText = postText.replaceAll("\n", " ");
                          if (postText.length > 100) {
                            postText = postText.substring(0, 100) +
                                "\nOpen Post to read more!";
                          }

                          return PostCard(
                            postTitle: posts[index].title,
                            postText: postText,
                            fullPostText: posts[index].content,
                            containsImage: posts[index].hasImage,
                            dateTime: posts[index].created,
                            objectId: posts[index].objectId,
                          );
                        }),
                  ],
                ),
              ],
            ),
            Selector<UserService, Tuple2>(
              selector: (context, value) =>
                  Tuple2(value.showUserProgress, value.userProgressText),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(text: '${value.item2}')
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
