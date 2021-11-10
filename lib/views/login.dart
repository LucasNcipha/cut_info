import 'package:cut_info/views/mainChat.dart';
import 'package:cut_info/views/register.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:backendless_sdk/backendless_sdk.dart';

final buttonWidth = 180.0;
final buttonHeight = 50.0;

const String APPLICATION_ID = "61B0CDD4-057B-F5CD-FFF8-3EFAA2EF6600";
const String ANDROID_API_KEY = "970C0F8A-D381-4CFB-BFB1-FD69BB01B5C7";
const String IOS_API_KEY = "03DD9078-DEDD-498E-9470-D022099FDF22";

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

bool autoLogin = false;

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    Backendless.initApp(
      applicationId: APPLICATION_ID,
      androidApiKey: ANDROID_API_KEY,
      iosApiKey: IOS_API_KEY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade400,
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade700, Colors.lightBlue.shade50])),
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
                  'Please Enter your student number and password ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Student Number'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(buttonWidth, buttonHeight),
                      primary: Colors.lightBlue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainChat(),
                      ),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
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
                  padding: const EdgeInsets.only(bottom: 20),
                  primary: Colors.lightBlue,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
                child: const Text('Sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
