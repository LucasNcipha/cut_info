import 'package:cut_info/models/post.dart';
import 'package:cut_info/services/helper_todo.dart';
import 'package:cut_info/widgets/post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {



  late TextEditingController postController;
  final posts = List<Post>.generate(10, (index) => Post("Tile $index","Content $index",false));
  @override
  void initState() {
    super.initState();
    postController = TextEditingController();
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Create a new Post'),
      content: Column(
        children: [
          TextField(

          ),
       ////////////////////TEXTBOX

        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () async {
            createNewTodoInUI(context,
                titleController: postController);
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
          child: ListView(
            children: [
              Column(
                children: [

                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:posts.length,
                      itemBuilder: (context,index){
                        return  PostCard(postTitle: posts[index].title, postText: posts[index].title, containsImage: posts[index].hasImage);
                      }),

                  //test post cards below !!
                  /*  post_card(
                    postTitle: 'hallo 1',
                    postText:
                        'this is some very long text to show that this text will fit into a very small screen without pixel overflowing...',
                    containsImage: false,
                  ),
                  post_card(
                    postTitle: 'hallo 2',
                    postText: 'post text here',
                    containsImage: false,
                  ),
                  post_card(
                    postTitle: 'hallo 3',
                    postText: 'post text here',
                    containsImage: false,
                  ), */
                ],
              ),
            ],
          )),
    );
  }
}
