import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownStatefulWidgetState();
}

/// This is the private State class that goes with DropDownWidget.
class _DropDownStatefulWidgetState extends State<DropDownWidget> {
  String dropdownValue = 'IT';
  String dropdownValue2 = 'Everyone';

  List<String> courses = <String>[
    'IT',
    'Marketing',
    'Somatology',
    'Mec Engineering',
    'Ele Engineering',
    'Hospitality'
  ];

  List<String> years = <String>[
    'Everyone',
    '1',
    '2',
    '3',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120,
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(
              Icons.arrow_downward,
              color: Colors.black,
            ),
            iconSize: 16,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 3,
              color: Colors.lightBlue.shade400,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
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
/* ...................................
................   drop down 1 end 
...................................... */
        Container(
          width: 120,
          child: DropdownButton<String>(
            value: dropdownValue2,
            icon: const Icon(
              Icons.arrow_downward,
              color: Colors.black,
            ),
            iconSize: 16,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 3,
              color: Colors.lightBlue.shade400,
            ),
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
        ),
      ],
    );
  }
}
