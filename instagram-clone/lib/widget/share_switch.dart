import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShareSwitch extends StatefulWidget {
  final String title;

  const ShareSwitch({Key key, @required this.title}) : super(key: key);

  @override
  _ShareSwitchState createState() => _ShareSwitchState();
}

class _ShareSwitchState extends State<ShareSwitch> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        widget.title,
        style: TextStyle(fontSize: 20.0),
      ),
      trailing: CupertinoSwitch(
        value: _value,
        onChanged: (value) {
          setState(
            () {
              _value = value;
            },
          );
        },
      ),
    );
  }
}
