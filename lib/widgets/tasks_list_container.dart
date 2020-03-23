import 'package:flutter/material.dart';
import 'package:fluttertodoey/constants/constants.dart';
import 'package:fluttertodoey/models/task_data.dart';
import 'package:fluttertodoey/widgets/tasks_list_tile.dart';
import 'package:provider/provider.dart';

class TasksListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerTask = Provider.of<TaskData>(context);
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
      child: ListView.builder(
        itemBuilder: (context, index) => TasksListTile(
          textName: providerTask.tasksList[index].name,
          isChecked: providerTask.tasksList[index].isDone,
          checkBoxCallBack: (currentValue) {
            Provider.of<TaskData>(context, listen: false)
                .updateTask(providerTask.tasksList[index]);
          },
          longPressed: () {
            providerTask.deleteTask(providerTask.tasksList[index]);
          },
        ),
        itemCount: providerTask.taskCount,
      ),
    );
  }
}
