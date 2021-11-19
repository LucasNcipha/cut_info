import 'package:cut_info/pages/loading.dart';
import 'package:cut_info/pages/main_page.dart';
import 'package:cut_info/pages/login.dart';
import 'package:cut_info/pages/register.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String registerPage = '/registerPage';
  static const String mainPage = '/mainPage';
  static const String loadingPage = '/loadingPage';

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
          builder: (context) => main_page(),
        );

      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => Loading(),
        );

      default:
        throw FormatException('Route not found! Check routes again!');
    }
  }
}
