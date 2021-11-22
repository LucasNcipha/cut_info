import 'package:cut_info/lifecycle.dart';
import 'package:cut_info/routes/routes.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserService(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => TodoService(),
        // )
      ],
      child: LifeCycle(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteManager.loadingPage,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
