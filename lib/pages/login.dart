import 'package:cut_info/routes/routes.dart';
import 'package:cut_info/services/helper_user.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:cut_info/widgets/app_progress_indicator.dart';
import 'package:cut_info/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

final buttonWidth = 180.0;
final buttonHeight = 50.0;

bool autoLogin = false;
bool emailValidate = false;
bool passwordlValidate = false;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.lightBlue.shade50],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: Text(
                        'Please Enter your email and password ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    AppTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      labelText: 'Please enter email address',
                      validate: emailValidate,
                    ),
                    AppTextField(
                        hideText: true,
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        labelText: 'Please enter your password',
                        validate: passwordlValidate),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: autoLogin,
                            onChanged: (bool? value) {
                              setState(() {
                                autoLogin = value!;
                              });
                            }),
                        Text('Keep me logged in')
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(buttonWidth, buttonHeight),
                          primary: Colors.lightBlue),
                      onPressed: () {
                        setState(() {
                          if (emailController.text.isEmpty) {
                            emailValidate = true;
                          }
                          if (passwordController.text.isEmpty) {
                            passwordlValidate = true;
                          }
                        });

                        loginUserInUI(context,
                            email: emailController.text.trim(),
                            password: passwordController.text);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Dont have an account yet ? ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(bottom: 10),
                        primary: Colors.lightBlue,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RouteManager.registerPage);
                      },
                      child: const Text('Sign up'),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(primary: Colors.purple),
                        onPressed: () async {
                          resetPasswordInUI(context,
                              email: emailController.text);
                        },
                        child: Text(
                          'Reset Your Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ))
                  ],
                ),
              ),
            ),
            Selector<UserService, Tuple2>(
              selector: (context, value) =>
                  Tuple2(value.showUserProgress, value.userProgressText),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(text: '${value.item2}')
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
