import 'package:cut_info/widgets/post_card.dart';
import 'package:flutter/cupertino.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PostCard(
            postTitle: 'Test 1',
            postText: 'Lorem ipsum dolor sit amet.',
            containsImage: false,
          ),
          PostCard(
            postTitle: 'Test 2',
            postText: 'Nulla facilisi morbi tempus.',
            containsImage: false,
          ),
          PostCard(
            postTitle: 'Test 3',
            postText: 'Lorem ipsum dolor sit amet consectetur.',
            containsImage: false,
          ),
          PostCard(
            postTitle: 'Test 4',
            postText: 'Sagittis nisl rhoncus mattis rhoncus urna.',
            containsImage: false,
          ),
          PostCard(
            postTitle: 'Test 5',
            postText: 'Lorem ipsum dolor sit amet.',
            containsImage: false,
          ),
          PostCard(
            postTitle: 'Test 6',
            postText: 'Nulla facilisi morbi tempus.',
            containsImage: false,
          ),
          PostCard(
            postTitle: 'Test 7',
            postText: 'Lorem ipsum dolor sit amet consectetur.',
            containsImage: false,
          ),
          PostCard(
            postTitle: 'Test 8',
            postText: 'Sagittis nisl rhoncus mattis rhoncus urna.',
            containsImage: false,
          ),
        ],
      ),
    );
  }
}
