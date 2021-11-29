import 'package:flutter/material.dart';

class RegisterYearDropDownWidget extends StatefulWidget {
  const RegisterYearDropDownWidget({Key? key}) : super(key: key);

  @override
  State<RegisterYearDropDownWidget> createState() =>
      _DropDownStatefulWidgetState();
}

/// This is the private State class that goes with RegisterYearDropDownWidget.
class _DropDownStatefulWidgetState extends State<RegisterYearDropDownWidget> {
  String dropdownValue2 = 'Year';

  List<String> years = <String>[
    'Year',
    '1',
    '2',
    '3',
    '4      (Extended)  ',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: dropdownValue2,
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
              dropdownValue2 = newValue!;
            });
          },
          items: years.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
