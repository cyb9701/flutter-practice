import 'package:flutter/material.dart';
import 'package:fluttertodoey/constants/constants.dart';
import 'package:fluttertodoey/models/task_data.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController textEditingController = TextEditingController();

  String addTaskName;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 50.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kRadiusValue),
            topRight: Radius.circular(kRadiusValue),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 70.0),
              height: 3.0,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(kRadiusValue),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kMainColor,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            TextField(
              onChanged: (String value) {
                addTaskName = value;
              },
              autofocus: true,
              textAlign: TextAlign.center,
              controller: textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kMainColor, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kMainColor, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kMainColor, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kMainColor, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Task',
                labelStyle: TextStyle(fontSize: 30.0, color: Colors.blueGrey),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: kMainColor,
              onPressed: () {
                if (addTaskName == null) {
                  Navigator.pop(context);
                } else if (addTaskName.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false)
                      .addNewTask(addTaskName);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
