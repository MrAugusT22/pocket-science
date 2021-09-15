import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static const String id = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(
      builder: (context, myThemeData, child) {
        _isDarkMode = myThemeData.getDarkMode;
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  elevation: 5,
                  shape: CircleBorder(),
                  color: Colors.transparent,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.blue,
                    child: Material(
                      elevation: 5,
                      shape: CircleBorder(),
                      color: Colors.transparent,
                      child: CircleAvatar(
                        radius: 95,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                    child: InvestmentCardText(
                        text: 'Sahil Shetye', fontSize: 30.0)),
                SizedBox(height: 10),
                Center(
                  child: InvestmentCardText(
                    text: 'sshetye466@gmail.com',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.blue,
                  thickness: 2,
                ),
                SizedBox(height: 10),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _isDarkMode ? kMyDarkBGColor : Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // CupertinoIcon
                            Icon(_isDarkMode ? Icons.bedtime_rounded : Icons.bedtime_outlined),
                            SizedBox(width: 10),
                            InvestmentCardText(text: 'Dark Mode'),
                          ],
                        ),
                        CupertinoSwitch(
                          activeColor: kMyColor,
                          value: _isDarkMode,
                          onChanged: (value) {
                            myThemeData.toggleDarkMode();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
