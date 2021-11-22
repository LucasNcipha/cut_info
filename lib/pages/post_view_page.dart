import 'package:flutter/material.dart';

class postView extends StatefulWidget {
  const postView({Key? key}) : super(key: key);

  @override
  State<postView> createState() => _postViewState();
}

class _postViewState extends State<postView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Back',
                onPressed: () {
                  Navigator.pop(context);
                }),
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
        ));
  }
}
