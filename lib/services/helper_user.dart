import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/routes/routes.dart';
import 'package:cut_info/services/todo_service.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:cut_info/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void createNewUserInUI(
  BuildContext context, {
  required String studentNumber,
  required String name,
  required String surname,
  required String course,
  required String year,
  required String password,
  required String passwordConfirm,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (name.isEmpty ||
      surname.isEmpty ||
      studentNumber.isEmpty ||
      course.isEmpty ||
      year.isEmpty ||
      password.isEmpty ||
      passwordConfirm.isEmpty) {
    showSnackBar(
      context,
      'Please enter all fields!',
    );
  } else {
    BackendlessUser user = BackendlessUser()
      ..email = name.trim()
      ..password = password.trim()
      ..putProperties({
        'name': name.trim(),
        'studentNumber': studentNumber.trim(),
      });

    String result = await context.read<UserService>().createUser(user);
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, 'New user successfully created!');
      Navigator.pop(context);
    }
  }
}

void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'Please enter both fields!');
  } else {
    String result = await context
        .read<UserService>()
        .loginUser(email.trim(), password.trim());
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      context.read<TodoService>().getTodos(email);
      Navigator.of(context).popAndPushNamed(RouteManager.todoPage);
    }
  }
}

void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context,
        'Please enter your email address then click on Reset Password again!');
  } else {
    String result =
        await context.read<UserService>().resetPassword(email.trim());
    if (result == 'OK') {
      showSnackBar(
          context, 'Successfully sent password reset. Please check your mail');
    } else {
      showSnackBar(context, result);
    }
  }
}

void logoutUserInUI(BuildContext context) async {
  String result = await context.read<UserService>().logoutUser();
  if (result == 'OK') {
    context.read<UserService>().setCurrentUserNull();
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  } else {
    showSnackBar(context, result);
  }
}
