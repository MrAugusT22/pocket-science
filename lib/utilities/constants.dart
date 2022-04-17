import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kMyAppName = 'Pocket Science';
const kMyImage = 'images/pig.jpg';

String mon = '';
int date = 0;
String monYr = '';

void formatDate(DateTime d) {
  var format = DateFormat('MMM');
  String date1 = format.format(d);
  mon = date1;
  var format2 = DateFormat('dd');
  String date2 = format2.format(d);
  int date3 = int.parse(date2);
  date = date3;

  var format3 = DateFormat('MMM yyyy');
  String date4 = format3.format(d);
  monYr = date4;
}

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

const kMyDarkBGColor = Color(0xFF3E3E3E);
const kMyLightBGColor = Colors.white;

ThemeData kMyLightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: kMyLightBGColor,
);
ThemeData kMyDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: kMyDarkBGColor,
);
