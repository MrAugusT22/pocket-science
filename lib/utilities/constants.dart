import 'package:flutter/material.dart';

const kMyGradient = LinearGradient(
  colors: [Colors.blue, Color(0xFF1A39D2)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kNonSelectedGradient = LinearGradient(
  colors: [Color(0xFF232222), Color(0xFF232222)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kMyDarkBGColor = Color(0xFF232222);
const kMyLightBGColor = Colors.white;
const kMyColor = Colors.blue;

ThemeData kMyLightTheme = ThemeData.light();
ThemeData kMyDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: kMyDarkBGColor,
);

InputDecoration kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(fontFamily: "RobotoMono"),
  hintText: '',
  contentPadding: EdgeInsets.all(20),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(20),
  ),
);

const dateFormat = '';