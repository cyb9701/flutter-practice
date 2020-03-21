import 'package:flutter/material.dart';

class TasksListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('data'),
      trailing: Checkbox(
        value: false,
        onChanged: (value) {},
      ),
    );
  }
}
