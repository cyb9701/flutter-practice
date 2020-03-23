import 'package:flutter/material.dart';
import 'package:fluttertodoey/constants/constants.dart';

class TasksListTile extends StatelessWidget {
  TasksListTile({
    @required this.textName,
    @required this.isChecked,
    @required this.checkBoxCallBack,
    @required this.longPressed,
  });

  final String textName;
  final bool isChecked;
  final Function checkBoxCallBack;
  final Function longPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        textName,
        style: TextStyle(
          fontSize: 20.0,
          decoration: isChecked ? TextDecoration.lineThrough : null,
          decorationColor: Colors.red[400],
        ),
      ),
      trailing: Checkbox(
        activeColor: kMainColor,
        value: isChecked,
        onChanged: checkBoxCallBack,
      ),
      onLongPress: longPressed,
    );
  }
}
