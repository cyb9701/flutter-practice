import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertodoey/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasksList = [];

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
