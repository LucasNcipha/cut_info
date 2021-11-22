import 'package:cut_info/models/post.dart';
import 'package:cut_info/pages/loading.dart';
import 'package:cut_info/pages/main_page.dart';
import 'package:cut_info/pages/login.dart';
import 'package:cut_info/pages/post_view_page.dart';
import 'package:cut_info/pages/register.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String registerPage = '/registerPage';
  static const String mainPage = '/mainPage';
  static const String postPage = '/postPage';
  static const String loadingPage = '/loadingPage';
  static Posts post = Posts("title", "content", false, DateTime.now());

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => Login(),
        );

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => Register(),
        );

      case mainPage:
        return MaterialPageRoute(
          builder: (context) => MainPage(),
        );

      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => Loading(),
        );

      case postPage:
        return MaterialPageRoute(
          builder: (context) => PostView(),
        );

      default:
        throw FormatException('Route not found! Check routes again!');
    }
  }
}
