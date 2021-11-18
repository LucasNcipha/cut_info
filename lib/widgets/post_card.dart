import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class post_card extends StatelessWidget {
  const post_card({
    Key? key,
    required this.postTitle,
    required this.postText,
    required this.containsImage,
  }) : super(key: key);

  final postTitle;
  final postText;
  final bool containsImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: Colors.blue.shade700,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(postTitle,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 10),
                      child: Text(
                        postText,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
