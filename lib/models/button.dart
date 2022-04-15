import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final text;
  final onPressed;
  final arrow;
  final textSize;
  final center;
  final buttonColor;
  final textColor;
  
  Button({
    this.text,
    this.onPressed,
    this.arrow = true,
    this.textSize = 30.0,
    this.center = false,
    this.textColor,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      fillColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: buttonColor,
        ),
        child: Row(
          mainAxisAlignment: center
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                // color: Colors.white,
                fontFamily: 'RobotoMono',
                fontSize: textSize,
                fontWeight: FontWeight.bold,
                color: buttonColor.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            arrow
                ? Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                    // color: Colors.white,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
