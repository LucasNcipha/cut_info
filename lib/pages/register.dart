import 'package:cut_info/services/helper_user.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:cut_info/widgets/app_progress_indicator.dart';
import 'package:cut_info/widgets/app_textfield.dart';
import 'package:cut_info/widgets/register_course_dropdown.dart';
import 'package:cut_info/widgets/register_year_dropdown.dart';
import 'package:cut_info/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController studentNumberController;
  late TextEditingController surnameController;
  late TextEditingController courseController;
  late TextEditingController yearController;
  late TextEditingController passwordConfirmController;
  bool emailValidate = false;
  bool nameValidate = false;
  bool passwordlValidate = false;
  bool studentNumberValidate = false;
  bool surnameValidate = false;
  bool passwordConfirmValidate = false;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    nameController = TextEditingController();
    studentNumberController = TextEditingController();
    surnameController = TextEditingController();
    courseController = TextEditingController();
    yearController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    studentNumberController.dispose();
    surnameController.dispose();
    courseController.dispose();
    yearController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 10),
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'Register User',
                        style: TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                    ),
                    Focus(
                      onFocusChange: (value) async {
                        if (!value) {
                          context.read<UserService>().checkIfUserExists(
                              studentNumberController.text.trim());
                        }
                      },
                      child: AppTextField(
                        keyboardType: TextInputType.text,
                        controller: emailController,
                        labelText: 'Please enter your Email',
                        validate: emailValidate,
                      ),
                    ),
                    Selector<UserService, bool>(
                      selector: (context, value) => value.userExists,
                      builder: (context, value, child) {
                        return value
                            ? Text(
                                'Email exists, please use another',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Container();
                      },
                    ),
                    AppTextField(
                      keyboardType: TextInputType.number,
                      controller: studentNumberController,
                      labelText: 'Please enter your Student Number',
                      validate: studentNumberValidate,
                    ),
                    AppTextField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        labelText: 'Please enter your name',
                        validate: nameValidate),
                    AppTextField(
                        keyboardType: TextInputType.text,
                        controller: surnameController,
                        labelText: 'Please enter your surname',
                        validate: surnameValidate),
                    // Course drop down
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: RegisterCourseDropDownWidget(),
                    ),
                    //
                    // Year drop down
                    Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: RegisterYearDropDownWidget()),
                    // drop downs end
                    //
                    AppTextField(
                        hideText: true,
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        labelText: 'Please enter your password',
                        validate: passwordlValidate),
                    // password validator in the UI
                    new FlutterPwValidator(
                        width: 300,
                        height: 150,
                        minLength: 6,
                        successColor: Colors.green,
                        failureColor: Colors.purple,
                        uppercaseCharCount: 1,
                        numericCharCount: 2,
                        controller: passwordController,
                        onSuccess: () {
                          showSnackBar(context, 'Password Validated');
                        }), // validator end
                    AppTextField(
                        hideText: true,
                        keyboardType: TextInputType.text,
                        controller: passwordConfirmController,
                        labelText: 'Please Confirm your password',
                        validate: passwordConfirmValidate),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                        onPressed: () {
                          setState(() {
                            if (emailController.text.isEmpty) {
                              emailValidate = true;
                            }
                            if (studentNumberController.text.isEmpty) {
                              studentNumberValidate = true;
                            }
                            if (nameController.text.isEmpty) {
                              nameValidate = true;
                            }
                            if (surnameController.text.isEmpty) {
                              surnameValidate = true;
                            }
                            if (passwordController.text.isEmpty) {
                              passwordlValidate = true;
                            }
                            if (passwordConfirmController.text.isEmpty) {
                              passwordConfirmValidate = true;
                            }
                          });
                          createNewUserInUI(
                            context,
                            email: emailController.text.trim(),
                            name: nameController.text.trim(),
                            surname: surnameController.text.trim(),
                            studentNumber: studentNumberController.text.trim(),
                            course: getDrowdownCourse().trim(),
                            year: getDropdownYear().trim(),
                            password: passwordController.text,
                            passwordConfirm: passwordConfirmController.text,
                          );
                        },
                        child: Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 30,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
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
    );
  }
}
