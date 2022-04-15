import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/my_color_picker.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Profile extends StatefulWidget {
  static const String id = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  bool value = true;

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

        Color pickerColor = Color(0xff13a6a8);
        Color currentColor = Color(0xff13a6a8);

        List<Widget> myColorPickerList = [
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
              // constraints: BoxConstraints.tightFor(width: 56, height: 56),
            ),
          ),
          MyColorPicker(color: Colors.blue),
          MyColorPicker(color: Colors.green),
          MyColorPicker(color: Colors.red),
          MyColorPicker(color: Colors.cyan),
          MyColorPicker(color: Colors.yellow),
        ];

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      value = !value;
                      myThemeData.toggleDarkMode(value);
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
                              },
                            ),
                          ],
                        ),
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
                        height: MediaQuery.of(context).size.width - 20,
                      ),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _isDarkMode ? kMyDarkBGColor : Colors.white),
                      child: StaggeredGrid.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 2,
                            child: myColorPickerList[0],
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1,
                            child: myColorPickerList[1],
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1,
                            child: myColorPickerList[2],
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1,
                            child: myColorPickerList[3],
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1,
                            child: myColorPickerList[4],
                          ),
                          StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1,
                            child: myColorPickerList[5],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InvestmentCardText(
                          text: 'Developer: Sahil Shetye',
                          fontStyle: FontStyle.italic,
                          color: _isDarkMode? Colors.white54 : Colors.black54,
                          fontSize: 12.0,
                          textAlign: TextAlign.center,
                        ),
                        Text(''),
                        InvestmentCardText(
                          text: 'Found a bug? Do let me know at',
                          fontStyle: FontStyle.italic,
                          color: _isDarkMode? Colors.white54 : Colors.black54,
                          fontSize: 12.0,
                          textAlign: TextAlign.center,
                        ),
                        InvestmentCardText(
                          text: '\"sshetye466@gmail.com\"',
                          fontStyle: FontStyle.italic,
                          color: _isDarkMode? Colors.white54 : Colors.black54,
                          fontSize: 12.0,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
