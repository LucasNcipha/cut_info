import 'package:flutter/material.dart';

String dropdownYear = '1';

String getDropdownYear() {
  return dropdownYear;
}

class RegisterYearDropDownWidget extends StatefulWidget {
  const RegisterYearDropDownWidget({Key? key}) : super(key: key);

  @override
  State<RegisterYearDropDownWidget> createState() =>
      _DropDownStatefulWidgetState();
}

/// This is the private State class that goes with RegisterYearDropDownWidget.
class _DropDownStatefulWidgetState extends State<RegisterYearDropDownWidget> {
  List<String> years = <String>[
    '1',
    '2',
    '3',
    '4',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownYear,
            icon: const Icon(
              Icons.arrow_downward,
              color: Colors.black,
            ),
            iconSize: 16,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(height: 3, color: Colors.grey),
            onChanged: (String? newValue) {
              setState(() {
                dropdownYear = newValue!;
              });
            },
            items: years.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
