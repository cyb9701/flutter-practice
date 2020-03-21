import 'package:flutter/material.dart';
import 'package:fluttertodoey/constants/constants.dart';
import 'package:fluttertodoey/widgets/tasks_list_tile.dart';

class TasksListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 53.0, right: 53.0, bottom: 60.0),
      height: size.height * 0.63,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kRadiusValue),
          topRight: Radius.circular(kRadiusValue),
        ),
      ),
      child: ListView(
        children: <Widget>[
          TasksListTile(),
          TasksListTile(),
          TasksListTile(),
          TasksListTile(),
        ],
      ),
    );
  }
}
