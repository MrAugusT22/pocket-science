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

ThemeData kMyLightTheme = ThemeData.light();
ThemeData kMyDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: kMyDarkBGColor,
);