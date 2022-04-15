import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fin_calc/screens/profile.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:fin_calc/screens/cagr.dart';
import 'package:fin_calc/screens/emi.dart';
import 'package:fin_calc/screens/sip.dart';

class HomePage extends StatefulWidget {
  static const String id = 'welcome_page';
  final isDarkMode;
  HomePage({this.isDarkMode});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Widget> _widgetOptions = [
    Sip(),
    Cagr(),
    Emi(),
    // Currency(),
    Profile(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, myThemeData, child) {
      Color kMyColor = myThemeData.getMyColor;

      return Scaffold(
        extendBody: true,
        body: _widgetOptions.elementAt(_currentIndex),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomNavyBar(
            selectedIndex: _currentIndex,
            showElevation: true,
            containerHeight: 65,
            itemCornerRadius: 20,
            curve: Curves.linear,
            onItemSelected: (index) => setState(() => _currentIndex = index),
            backgroundColor: kMyColor,
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(5),
                    child: _currentIndex == 0
                        ? Icon(Icons.payments_rounded)
                        : Icon(Icons.payments_outlined),
                  ),
                  title: Text('SIP'),
                  activeColor: Colors.white,
                  textAlign: TextAlign.center,
                  inactiveColor: Colors.white54),
              BottomNavyBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5),
                  child: _currentIndex == 1
                      ? Icon(Icons.savings_rounded)
                      : Icon(Icons.savings_outlined),
                ),
                title: Text('CAGR'),
                activeColor: Colors.white,
                textAlign: TextAlign.center,
                inactiveColor: Colors.white54,
              ),
              BottomNavyBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5),
                  child: _currentIndex == 2
                      ? Icon(Icons.payment_rounded)
                      : Icon(Icons.payment_outlined),
                ),
                title: Text(
                  'EMI',
                ),
                activeColor: Colors.white,
                textAlign: TextAlign.center,
                inactiveColor: Colors.white54,
              ),
              // BottomNavyBarItem(
              //   icon: Padding(
              //     padding: EdgeInsets.all(5),
              //     child: _currentIndex == 3
              //         ? Icon(Icons.paid_rounded)
              //         : Icon(Icons.paid_outlined),
              //   ),
              //   title: Text('Cryptos'),
              //   activeColor: Colors.white,
              //   textAlign: TextAlign.center,
              //   inactiveColor: Colors.white54,
              // ),
              BottomNavyBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5),
                  child: _currentIndex == 3
                      ? Icon(Icons.settings_rounded)
                      : Icon(Icons.settings_outlined),
                ),
                title: Text('Settings'),
                activeColor: Colors.white,
                textAlign: TextAlign.center,
                inactiveColor: Colors.white54,
              ),
            ],
          ),
        ),
      );
    });
  }
}
