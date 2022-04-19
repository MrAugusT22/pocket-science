import 'package:fin_calc/screens/cagr.dart';
import 'package:fin_calc/screens/emi.dart';
import 'package:fin_calc/screens/profile.dart';
import 'package:fin_calc/screens/sip.dart';
import 'package:fin_calc/screens/home.dart';
import 'package:fin_calc/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'utilities/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(
    FinCalc(),
  );
}

class FinCalc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserData>(
      create: (context) => UserData(),
      child: Consumer<UserData>(
        builder: (context, myThemeData, child) {
          myThemeData.getAccentColor();
          return MaterialApp(
            theme: myThemeData.getDarkMode ? kMyDarkTheme : kMyLightTheme,
            initialRoute: WelcomeScreen.id, //googleUserSign ? HomePage.id : WelcomeScreen.id,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              HomePage.id: (context) => Center(child: HomePage()),
              Profile.id: (context) => Profile(),
              Sip.id: (context) => Sip(),
              Cagr.id: (context) => Cagr(),
              Emi.id: (context) => Emi(),
            },
          );
        },
      ),
    );
  }
}
