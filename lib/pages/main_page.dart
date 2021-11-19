import 'package:cut_info/services/helper_todo.dart';
import 'package:cut_info/widgets/post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class main_page extends StatefulWidget {
  const main_page({Key? key}) : super(key: key);

  @override
  _main_pageState createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  late TextEditingController postController;

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
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade700, Colors.lightBlue.shade50],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 50, bottom: 10),
                child: Row(
                  children: [
                    Positioned(
                      left: 20,
                      top: 40,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text('Create a new Post'),
                                content: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Please enter post text here'),
                                  controller: postController,
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
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
          )),
    );
  }
}
