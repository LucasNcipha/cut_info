import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/routes/routes.dart';
import 'package:cut_info/services/todo_service.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InitApp {
  static final String applicationId = 'B927BE76-3E2D-9A26-FF73-AD42BB2E7200';
  static final String androidApiKey = '5C29D623-AD80-4B11-B5D5-13BE0353E91A';
  static final String iosApiKey = '9BEB7DDB-6F4C-4DC0-961D-60EC94A4023D';

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        applicationId: applicationId,
        iosApiKey: iosApiKey,
        androidApiKey: androidApiKey);
    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'OK') {
      context
          .read<TodoService>()
          .getTodos(context.read<UserService>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.mainPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
