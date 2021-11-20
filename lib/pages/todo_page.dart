import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/services/helper_todo.dart';
import 'package:cut_info/services/helper_user.dart';
import 'package:cut_info/services/todo_service.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:cut_info/widgets/app_progress_indicator.dart';
import 'package:cut_info/widgets/post_card.dart';
import 'package:cut_info/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tuple/tuple.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late TextEditingController todoController;

  @override
  void initState() {
    super.initState();
    todoController = TextEditingController();
  }

  @override
  void dispose() {
    todoController.dispose();
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
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                  PostCard(
                    postTitle: 'hallo',
                    postText: 'post text here',
                    containsImage: false,
                    dateTime: DateTime.now(),
                  ),
                  PostCard(
                    postTitle: 'hallo',
                    postText: 'post text here',
                    containsImage: false,
                    dateTime: DateTime.now(),
                  ),
                  PostCard(
                    postTitle: 'hallo',
                    postText: 'post text here',
                    containsImage: false,
                    dateTime: DateTime.now(),
                  ),
                  PostCard(
                    postTitle: 'hallo',
                    postText: 'post text here',
                    containsImage: false,
                    dateTime: DateTime.now(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            refreshTodosInUI(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            saveAllTodosInUI(context);
                          },
                        ),
                        IconButton(
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
                                  title: Text('Create a new TODO'),
                                  content: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Please enter TODO'),
                                    controller: todoController,
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
                                            titleController: todoController);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            logoutUserInUI(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: provider.Selector<UserService, BackendlessUser?>(
                      selector: (context, value) => value.currentUser,
                      builder: (context, value, child) {
                        return value == null
                            ? Container()
                            : Text(
                                '${value.getProperty('name')}\'s Notification list',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                ),
                              );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 20),
                      child: provider.Consumer<TodoService>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            itemCount: value.todos.length,
                            itemBuilder: (context, index) {
                              return TodoCard(
                                todo: value.todos[index],
                                todoToggleAction: (valueStatus) async {
                                  context
                                      .read<TodoService>()
                                      .toggleTodoDone(index);
                                },
                                deleteAction: () async {
                                  context
                                      .read<TodoService>()
                                      .deleteTodo(value.todos[index]);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            provider.Selector<UserService, Tuple2>(
              selector: (context, value) =>
                  Tuple2(value.showUserProgress, value.userProgressText),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(text: value.item2)
                    : Container();
              },
            ),
            provider.Selector<TodoService, Tuple2>(
              selector: (context, value) =>
                  Tuple2(value.busyRetrieving, value.busySaving),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(
                        text:
                            'Busy retrieving data from the database...please wait...')
                    : value.item2
                        ? AppProgressIndicator(
                            text:
                                'Busy saving data to the database...please wait...')
                        : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
