import 'package:cut_info/views/login.dart';
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

var snackBar;
var showSnack = false;

class Register extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                  'Welcome! ',
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
                  'Lets get you started ',
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
                decoration: InputDecoration(hintText: 'Enter your Name'),
                controller: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter your Surname'),
                controller: surnameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration:
                    InputDecoration(hintText: 'Enter your student Number'),
                keyboardType: TextInputType.number,
                controller: studentNumberController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter your Course'),
                controller: courseController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration:
                    InputDecoration(hintText: 'Enter your year of study'),
                keyboardType: TextInputType.number,
                controller: yearController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter password'),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Confirm password'),
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
                  name = nameController.text.trim();
                  surname = surnameController.text.trim();
                  studentNumber = studentNumberController.text.trim();
                  course = courseController.text.trim();
                  year = yearController.text.trim();
                  password = passwordController.text;
                  passwordConfirm = passwordConfirmController.text;

                  if (name == "" ||
                      surname == "" ||
                      studentNumber == "" ||
                      course == "" ||
                      year == null ||
                      password == "" ||
                      passwordConfirm == "") {
                    showSnack = true;
                    snackBar = SnackBar(
                        content: Text('Please fill in all the fields!'));
                  } else if (password == passwordConfirm) {
                    showSnack = false;
                  } else {
                    showSnack = true;
                    snackBar = SnackBar(
                        content: Text(
                            'Password and Confirm password does not match!'));
                  }
                  if (showSnack == true)
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Already have an account ? ',
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
                    builder: (context) => Login(),
                  ),
                );
              },
              child: const Text('Sign in'),
            )
          ]),
        ),
      ),
    );
  }
}
