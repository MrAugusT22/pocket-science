import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputTextField extends StatelessWidget {
  InputTextField({
    this.hintText,
    required this.textEditingController,
    this.prefixText,
    this.suffixText,
    required this.onChanged,
  });

  final textEditingController;
  final hintText;
  final prefixText;
  final suffixText;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      return Expanded(
        child: TextField(
          keyboardType: TextInputType.number,
          controller: textEditingController,
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            prefixText: prefixText,
            prefixStyle: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white12 : Colors.black54),
            suffixText: suffixText,
            suffixStyle: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white12 : Colors.black54),
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white12 : Colors.black54),
            enabledBorder: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      );
    });
  }
}
