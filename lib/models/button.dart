import 'package:fin_calc/utilities/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:provider/provider.dart';

class Button extends StatelessWidget {
  final text;
  final onPressed;
  final arrow;
  final textSize;
  final center;
  final color;
  Button({
    this.text,
    this.onPressed,
    this.arrow = true,
    this.textSize = 30.0,
    this.center = false,
    this.color = kMyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      return RawMaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        fillColor: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Row(
            mainAxisAlignment: center
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'RobotoMono',
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              arrow
                  ? Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 30,
                      color: Colors.white,
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }
}
