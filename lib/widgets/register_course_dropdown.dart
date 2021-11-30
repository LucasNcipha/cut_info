import 'package:flutter/material.dart';

String dropdownCourse = 'IT';

String getDrowdownCourse() {
  return dropdownCourse;
}

class RegisterCourseDropDownWidget extends StatefulWidget {
  const RegisterCourseDropDownWidget({Key? key}) : super(key: key);

  @override
  State<RegisterCourseDropDownWidget> createState() =>
      _DropDownStatefulWidgetState();
}

/// This is the private State class that goes with RegisterCourseDropDownWidget.
class _DropDownStatefulWidgetState extends State<RegisterCourseDropDownWidget> {
  List<String> courses = <String>[
    'IT',
    'Marketing',
    'Somatology',
    'Mec Engineering',
    'Ele Engineering',
    'Hospitality'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownCourse,
            icon: const Icon(
              Icons.arrow_downward,
              color: Colors.black,
            ),
            iconSize: 16,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 3,
              color: Colors.grey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownCourse = newValue!;
              });
            },
            items: courses.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
