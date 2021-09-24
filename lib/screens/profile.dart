import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_calc/models/button.dart';
import 'package:fin_calc/screens/welcome_screen.dart';
import 'package:fin_calc/services/firebase_services.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/my_color_picker.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static const String id = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Colors.red;
  Color topColor = Colors.yellow;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        bottomColor = Colors.blue;
      });
    });
    return Consumer<UserData>(
      builder: (context, myThemeData, child) {
        bool _isDarkMode = myThemeData.getDarkMode;
        Color kMyColor = myThemeData.getMyColor;

        Color pickerColor = Color(0xff443a49);
        Color currentColor = Color(0xff443a49);

        List userData = myThemeData.getUserData;
        print(userData);

        List myColorPickerList = [
          GestureDetector(
            onTap: () async {
              void changeColor(Color color) {
                setState(() => pickerColor = color);
              }

              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                        showLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: InvestmentCardText(text: 'Ok'),
                        onPressed: () {
                          setState(() => currentColor = pickerColor);
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: InvestmentCardText(text: 'Cancel'),
                        onPressed: () {
                          pickerColor = kMyColor;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              myThemeData.updateMyColor(pickerColor);
              FirebaseService(
                                      uid: userData[3], context: context)
                                  .updateUserData(
                                      color:
                                          '${pickerColor.value.toRadixString(16)}',
                                      isDarkMode: _isDarkMode);
            },
            child: AnimatedContainer(
              duration: Duration(seconds: 2),
              onEnd: () {
                setState(() {
                  index = index + 1;
                  // animate the color
                  bottomColor = colorList[index % colorList.length];
                  topColor = colorList[(index + 1) % colorList.length];

                  //// animate the alignment
                  begin = alignmentList[index % alignmentList.length];
                  end = alignmentList[(index + 2) % alignmentList.length];
                });
              },
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: begin,
                  end: end,
                  colors: [bottomColor, topColor],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              constraints: BoxConstraints.tightFor(width: 56, height: 56),
            ),
          ),
          MyColorPicker(color: Colors.blue),
          MyColorPicker(color: Colors.green),
          MyColorPicker(color: Colors.red),
          MyColorPicker(color: Colors.cyan),
          MyColorPicker(color: Colors.yellow),
          MyColorPicker(color: Colors.black),
          MyColorPicker(color: Colors.white),
          MyColorPicker(color: Colors.amber),
        ];

        bool googleUserSignIn = myThemeData.getGoogleUserSignInStatus;

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Material(
                    elevation: 5,
                    shape: CircleBorder(),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: kMyColor,
                      child: Material(
                        elevation: 5,
                        shape: CircleBorder(),
                        child: googleUserSignIn
                            ? CircleAvatar(
                                radius: 95,
                                backgroundImage: NetworkImage(userData[2]),
                              )
                            : CircleAvatar(
                                radius: 95,
                                backgroundColor: _isDarkMode
                                    ? kMyDarkBGColor
                                    : kMyLightBGColor,
                                child: InvestmentCardText(
                                  text:
                                      '${userData[0][0].toString().toUpperCase()}',
                                  fontSize: 60.0,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                      child: InvestmentCardText(
                          text: '${userData[0]}', fontSize: 30.0)),
                  SizedBox(height: 10),
                  Center(
                    child: InvestmentCardText(
                      text: '${userData[1]}',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    constraints: BoxConstraints.tightFor(
                        height: 2,
                        width: MediaQuery.of(context).size.width - 50),
                    decoration: BoxDecoration(
                      color: kMyColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                              Icon(_isDarkMode
                                  ? Icons.bedtime_rounded
                                  : Icons.bedtime_outlined),
                              SizedBox(width: 10),
                              InvestmentCardText(text: 'Dark Mode'),
                            ],
                          ),
                          CupertinoSwitch(
                            activeColor: kMyColor,
                            value: _isDarkMode,
                            onChanged: (value) {
                              myThemeData.toggleDarkMode(value);
                              FirebaseService(
                                      uid: userData[3], context: context)
                                  .updateUserData(
                                      color:
                                          '${kMyColor.value.toRadixString(16)}',
                                      isDarkMode: value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    child: Container(
                      constraints: BoxConstraints.tightFor(
                        height: 96,
                      ),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _isDarkMode ? kMyDarkBGColor : Colors.white),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 5);
                        },
                        physics: BouncingScrollPhysics(),
                        itemCount: myColorPickerList.length,
                        itemBuilder: (context, index) {
                          return myColorPickerList[index];
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      googleUserSignIn
                          ? myThemeData.googleLogout()
                          : _auth.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, WelcomeScreen.id, (route) => false);
                    },
                    child: Material(
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
                            InvestmentCardText(text: 'Log Out'),
                            SizedBox(width: 10),
                            Icon(Icons.power_settings_new_rounded),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
