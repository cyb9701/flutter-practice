import 'package:flutter/material.dart';

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
      color: Colors.grey.withOpacity(0.3),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
