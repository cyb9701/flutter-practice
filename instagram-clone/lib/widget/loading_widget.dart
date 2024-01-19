import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({
    @required this.width,
    @required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      color: kMenuColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
