import 'package:cut_info/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatelessWidget {
  const PostCard(
      {Key? key,
      required this.postTitle,
      required this.postText,
      required this.containsImage,
      required this.dateTime})
      : super(key: key);

  final postTitle;
  final postText;
  final bool containsImage;
  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteManager.postPage);
        },
        child: Card(
          child: ListTile(
            tileColor: Colors.lightBlue.shade400,
            title: Text(
              "$postTitle",
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "$postText",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("$dateTime"),
                    ],
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}
