import 'package:cut_info/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.todo,
    required this.deleteAction,
    required this.todoToggleAction,
  }) : super(key: key);
  final Todo todo;
  final Function() deleteAction;
  final Function(bool? value) todoToggleAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue.shade300,
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            caption: 'Comment',
            color: Colors.blue,
            icon: Icons.comment_outlined,
            onTap: deleteAction,
          ),
        ],
        child: CheckboxListTile(
          checkColor: Colors.blue,
          activeColor: Colors.blue[200],
          value: todo.done,
          onChanged: todoToggleAction,
          subtitle: Text(
            '${todo.created.day}/${todo.created.month}/${todo.created.year}',
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              color: Colors.white,
              decoration:
                  todo.done ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
