import 'package:flutter/material.dart';
import 'package:fluttertodoey/constants/constants.dart';
import 'package:fluttertodoey/models/task_data.dart';
import 'package:fluttertodoey/pages/add_task_page.dart';
import 'package:fluttertodoey/widgets/tasks_list_container.dart';
import 'package:provider/provider.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kMainColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskPage(),
              ),
            ),
          );
        },
        backgroundColor: kMainColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35.0,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 70.0,
            right: 0.0,
            left: 50.0,
            child: SafeArea(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(
                        Icons.list,
                        size: 40.0,
                        color: kMainColor,
                      ),
                      radius: 27.0,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Todoey',
                      style: TextStyle(
                          color: kTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      ' ${Provider.of<TaskData>(context).taskCount} Tasks',
                      style: TextStyle(color: kTitleColor, fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: TasksListContainer(),
          ),
        ],
      ),
    );
  }
}
