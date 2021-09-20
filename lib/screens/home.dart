import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fin_calc/screens/calculators.dart';
import 'package:fin_calc/screens/dashboard.dart';
import 'package:fin_calc/screens/expenses.dart';
import 'package:fin_calc/screens/profile.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  static const String id = 'welcome_page';
  final isDarkMode;
  HomePage({this.isDarkMode});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  int _currentIndex = 0;

  void getUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  static List<Widget> _widgetOptions = [
    Dashboard(),
    Expenses(),
    Calculator(),
    Profile(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
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
                        ? Icon(Icons.home_rounded)
                        : Icon(Icons.home_outlined),
                  ),
                  title: Text('Home'),
                  activeColor: Colors.white,
                  textAlign: TextAlign.center,
                  inactiveColor: Colors.white54),
              BottomNavyBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5),
                  child: _currentIndex == 1
                      ? Icon(Icons.pie_chart_rounded)
                      : Icon(Icons.pie_chart_outline_rounded),
                ),
                title: Text('Expenses'),
                activeColor: Colors.white,
                textAlign: TextAlign.center,
                inactiveColor: Colors.white54,
              ),
              BottomNavyBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5),
                  child: _currentIndex == 2
                      ? Icon(Icons.calculate_rounded)
                      : Icon(Icons.calculate_outlined),
                ),
                title: Text(
                  'Calculators',
                ),
                activeColor: Colors.white,
                textAlign: TextAlign.center,
                inactiveColor: Colors.white54,
              ),
              BottomNavyBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5),
                  child: _currentIndex == 3
                      ? Icon(Icons.settings)
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
