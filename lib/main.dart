import 'package:flutter/material.dart';
import 'package:fluttertiempo/pages/loading_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData.dark().copyWith(
        canvasColor: Colors.transparent,
      ),
      home: LoadingPage(),
    );
  }
}
