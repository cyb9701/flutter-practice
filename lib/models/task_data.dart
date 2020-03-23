import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertodoey/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasksList = [
    Task(name: 'Num 1'),
    Task(name: 'Num 2'),
    Task(name: 'Num 3'),
    Task(name: 'Num 4'),
  ];

  UnmodifiableListView<Task> get tasksList {
    return UnmodifiableListView(_tasksList);
  }

  void addNewTask(String newValue) {
    final newTask = Task(name: newValue);
    _tasksList.add(newTask);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasksList.remove(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleState();
    notifyListeners();
  }

  int get taskCount {
    return _tasksList.length;
  }
}
