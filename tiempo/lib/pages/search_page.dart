import 'package:flutter/material.dart';
import 'package:fluttertiempo/constants/constants.dart';
import 'package:fluttertiempo/pages/loading_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController;
  String cityName;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 50.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 5.0,
              width: size.width * 0.15,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'City',
              textScaleFactor: 4,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Form(
              key: _formKey,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: _textEditingController,
                decoration: kTextFieldDecoration,
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                cityName = _textEditingController.text;
                Navigator.pop(context, cityName);
                print('@@@@@@ City:${_textEditingController.text} @@@@@@');
              },
              child: Container(
                width: size.width,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey),
                child: Text(
                  'Search',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
