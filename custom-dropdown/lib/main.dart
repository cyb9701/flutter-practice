import 'package:custom_drop_box/flutter_dropdown_page.dart';
import 'package:custom_drop_box/normal_dropdown_page.dart';
import 'package:custom_drop_box/text_field_dropdown_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 기본 드롭 박스.
            CupertinoButton(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FlutterDropdownPage(),
                  ),
                );
              },
              child: const Text(
                'Flutter 기본 드롭박스',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            // 여백.
            const SizedBox(height: 20),

            // 커스텀 드롭 박스.
            CupertinoButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomDropdownPage(),
                  ),
                );
              },
              child: const Text(
                '커스텀 드롭박스',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            // 여백.
            const SizedBox(height: 20),

            // 커스텀 입력창 드롭 박스.
            CupertinoButton(
              color: Colors.amberAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomTextFieldDropdownPage(),
                  ),
                );
              },
              child: const Text(
                '입력창 드롭박스',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
