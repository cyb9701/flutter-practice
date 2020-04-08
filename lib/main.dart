import 'package:flutter/material.dart';
import 'package:flutterbmicalculator/pages/input_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*initialRoute: 'input',
      routes: {
        'input': (context) => InputPage(),
        'result': (context) => ResultPage(),
      },*/
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF1E2033),
        scaffoldBackgroundColor: Color(0xFF0A0D22),
      ),
      title: 'flutter_bmi_calculator',
      home: InputPage(),
    );
  }
}
