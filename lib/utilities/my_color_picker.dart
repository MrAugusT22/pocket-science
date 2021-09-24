import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_calc/services/firebase_services.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyColorPicker extends StatelessWidget {
  final color;

  MyColorPicker({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, myThemeData, child) {
      List userData = myThemeData.getUserData;
      bool _isDarkMode = myThemeData.getDarkMode;

      return GestureDetector(
        onTap: () {
          myThemeData.updateMyColor(color);
          FirebaseService(uid: userData[3], context: context).updateUserData(
              color: '${color.value.toRadixString(16)}',
              isDarkMode: _isDarkMode);
        },
        child: Container(
          constraints: BoxConstraints.tightFor(width: 56, height: 56),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
    },);
  }
}
