import 'package:flutter/material.dart';

final buttonWidth = 210.0;
final buttonHeight = 60.0;

var name;
var surname;
var studentNumber;
var course;
var year;
var password;
var passwordConfirm;

final nameController = TextEditingController();
final surnameController = TextEditingController();
final studentNumberController = TextEditingController();
final courseController = TextEditingController();
final yearController = TextEditingController();
final passwordController = TextEditingController();
final passwordConfirmController = TextEditingController();

class Register extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    surnameController.dispose();
    studentNumberController.dispose();
    courseController.dispose();
    yearController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade700, Colors.lightBlue.shade50])),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image(
                image: AssetImage('assets/logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Center(
                child: Text(
                  "Welcome! ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  "Lets get you started ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter your Name"),
                controller: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter your Surname"),
                controller: surnameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration:
                    InputDecoration(hintText: "Enter your student Number"),
                keyboardType: TextInputType.number,
                controller: studentNumberController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter your Course"),
                controller: courseController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration:
                    InputDecoration(hintText: "Enter your year of study"),
                keyboardType: TextInputType.number,
                controller: yearController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Enter password"),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Confirm password"),
                obscureText: true,
                controller: passwordConfirmController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(buttonWidth, buttonHeight),
                    primary: Colors.lightBlue),
                onPressed: () {
                  name = nameController.text;
                  surname = surnameController.text;
                  studentNumber = studentNumberController.text;
                  course = courseController.text;
                  year = yearController.text;
                  password = passwordController.text;
                  passwordConfirm = passwordConfirmController.text;

                  var snackBar;
                  if (name == "" ||
                      surname == "" ||
                      studentNumber == "" ||
                      course == "" ||
                      year == null ||
                      password == "" ||
                      passwordConfirm == "") {
                    snackBar = SnackBar(
                        content: Text('Please fill in all the fields!'));
                  } else if (password == passwordConfirm) {
                  } else {
                    snackBar = SnackBar(
                        content: Text(
                            'Password and Confirm password does not match!'));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Text(
              "Already have an account ?Sign in ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }
}
