import 'package:cut_info/views/login.dart';
import 'package:cut_info/views/register.dart';
import 'package:flutter/material.dart';

final buttonWidth = 120.0;
final buttonHeight = 30.0;
final buttonPadding = 10.0;

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade700, Colors.lightBlue.shade50])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 60),
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text('Welcome',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 25)),
                ),
                Text("If you have an account please Login"),
                Padding(
                  padding: EdgeInsets.all(buttonPadding),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, buttonHeight),
                        primary: Colors.green),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: Text("Login"),
                  ),
                ),
                Text("Or create an account by pressing the Register button."),
                Padding(
                  padding: EdgeInsets.all(buttonPadding),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, buttonHeight),
                        primary: Colors.red),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: Text("Register"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
