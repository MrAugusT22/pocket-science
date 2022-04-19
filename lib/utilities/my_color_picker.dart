import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyColorPicker extends StatelessWidget {
  final color;

  MyColorPicker({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, myThemeData, child) {
        return GestureDetector(
          onTap: () {
            myThemeData.updateMyColor(color);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              child: Container(
                // constraints: BoxConstraints.tightFor(width: 56, height: 56),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
