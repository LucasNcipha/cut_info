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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Text(
                "Please Enter your student number and password ",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Student Number"),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Password"),
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
                    Text("Keep me logged in")
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
                  //Test Backendless///////////////////////////////////////////////////////
                  Map testObject = new Map();
                  testObject["foo"] = "bar";
                  Backendless.data.of("TestTable").save(testObject).then(
                      (response) => print(
                          "Object is saved in Backendless. Please check in the console."));
                  /////////////////////////////////////////////////////////////////////////
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
