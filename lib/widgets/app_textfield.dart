import 'package:flutter/material.dart';

bool getvalidate(bool validate) {
  return validate;
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.hideText = false,
    required this.validate,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool hideText;
  final bool validate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
      child: TextField(
        obscureText: hideText,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.white,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorText: validate ? 'All fields must be filled' : null,
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
