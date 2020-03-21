import 'package:flutter/material.dart';
import 'package:fluttertodoey/constants/constants.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

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
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.blueGrey),
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
              onPressed: () {},
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
