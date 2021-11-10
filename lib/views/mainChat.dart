import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class mainChat extends StatefulWidget {
  const mainChat({Key? key}) : super(key: key);

  @override
  State<mainChat> createState() => _mainChatState();
}

class _mainChatState extends State<mainChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.blue.shade700,
                      Colors.lightBlue.shade50
                    ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 40),
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                        ),
                      )
                    ]),
                  ],
                ))));
  }
}
