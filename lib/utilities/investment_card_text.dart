import 'package:flutter/material.dart';

class InvestmentCardText extends StatelessWidget {
  final text;
  final fontSize;
  final fontStyle;
  final fontWeight;
  final color;
  final textAlign;
  InvestmentCardText({
    this.text,
    this.fontSize = 15.0,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.bold,
    this.color,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'RobotoMono',
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
      ),
      textAlign: textAlign,
      softWrap: true,
      overflow: TextOverflow.fade,
    );
  }
}
