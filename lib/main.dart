import 'package:flutter/material.dart';
import 'package:fluttertodoey/pages/tasks_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoey',
      home: TasksPage(),
    );
  }
}
