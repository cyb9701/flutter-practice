import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutteridmemo/pages/log_in_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("DB");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        canvasColor: Colors.transparent,
      ),
      title: 'ID_Memo_Memo',
      home: LogInPage(),
    );
  }
}
