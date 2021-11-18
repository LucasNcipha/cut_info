import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class post_card extends StatelessWidget {
  const post_card({
    Key? key,
    required String postTitle,
    required String postText,
    required bool containsImage,
  }) : super(key: key);

  final postTitle = '';
  final postText = '';
  final bool containsImage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(postTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
            ),
            Text(
              postText,
              style: TextStyle(color: Colors.white, fontSize: 10),
            )
          ],
        ));
  }
}
