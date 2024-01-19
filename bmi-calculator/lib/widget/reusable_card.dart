import 'package:flutter/material.dart';

class ReUsableCard extends StatelessWidget {
  ReUsableCard({@required this.color, this.childCard, this.onPress});

  final Color color;
  final Widget childCard;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(15),
        child: childCard,
      ),
    );
  }
}
