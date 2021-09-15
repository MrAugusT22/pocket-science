import 'package:flutter/material.dart';

class InvestmentCardText extends StatelessWidget {
  final text;
  final fontSize;
  final fontStyle;
  final fontWeight;
  InvestmentCardText({
    this.text,
    this.fontSize = 15.0,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.bold,
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
      ),
      softWrap: true,
    );
  }
}
