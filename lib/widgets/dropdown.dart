import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownStatefulWidgetState();
}

/// This is the private State class that goes with DropDownWidget.
class _DropDownStatefulWidgetState extends State<DropDownWidget> {
  String dropdownValue = 'Course';
  String dropdownValue2 = 'Year';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
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
            color: Colors.blue.shade800,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>[
            'Course',
            'IT',
            'Marketing',
            'Somatology',
            'Mec Engineering',
            'Ele Engineering',
            'Hospitality'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
/* ...................................
................   drop down 1 end 
...................................... */
        Padding(
          padding: const EdgeInsets.only(left: 10),
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
              color: Colors.blue.shade800,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue2 = newValue!;
              });
            },
            items: <String>[
              'Year',
              '1',
              '2',
              '3',
              '4(Extended)',
            ].map<DropdownMenuItem<String>>((String value) {
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
