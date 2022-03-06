import 'package:flutter/material.dart';

class FlutterDropdownPage extends StatefulWidget {
  const FlutterDropdownPage({Key? key}) : super(key: key);

  @override
  State<FlutterDropdownPage> createState() => _FlutterDropdownPageState();
}

class _FlutterDropdownPageState extends State<FlutterDropdownPage> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['One', 'Two', 'Three', 'Four', 'Five']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
