import 'package:fin_calc/screens/cagr.dart';
import 'package:fin_calc/screens/calculators.dart';
import 'package:fin_calc/screens/currency.dart';
import 'package:fin_calc/screens/dashboard.dart';
import 'package:fin_calc/screens/emi.dart';
import 'package:fin_calc/screens/expenses.dart';
import 'package:fin_calc/screens/profile.dart';
import 'package:fin_calc/screens/sip.dart';
import 'package:fin_calc/screens/home.dart';
import 'package:fin_calc/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'utilities/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          bool googleUserSign = myThemeData.getGoogleUserSignInStatus;
          print(googleUserSign);
          return MaterialApp(
            theme: myThemeData.getDarkMode ? kMyDarkTheme : kMyLightTheme,
            initialRoute: googleUserSign ? HomePage.id : WelcomeScreen.id,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              HomePage.id: (context) => Center(child: HomePage()),
              Dashboard.id: (context) => Dashboard(),
              Expenses.id: (context) => Expenses(),
              Calculator.id: (context) => Calculator(),
              Profile.id: (context) => Profile(),
              Sip.id: (context) => Sip(),
              Cagr.id: (context) => Cagr(),
              Emi.id: (context) => Emi(),
              Currency.id: (context) => Currency(),
            },
          );
        },
      ),
    );
  }
}
