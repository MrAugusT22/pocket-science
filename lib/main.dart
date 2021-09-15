import 'package:fin_calc/screens/cagr.dart';
import 'package:fin_calc/screens/calculators.dart';
import 'package:fin_calc/screens/currency.dart';
import 'package:fin_calc/screens/dashboard.dart';
import 'package:fin_calc/screens/emi.dart';
import 'package:fin_calc/screens/profile.dart';
import 'package:fin_calc/screens/sip.dart';
import 'package:fin_calc/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fin_calc/utilities/theme_data.dart';

import 'utilities/constants.dart';

void main() {
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
    return ChangeNotifierProvider<MyThemeData>(
      create: (context) => MyThemeData(),
      child: Consumer<MyThemeData>(builder: (context, myThemeData, child) {
        return MaterialApp(
          theme: myThemeData.getDarkMode ? kMyDarkTheme : kMyLightTheme,
          initialRoute: HomePage.id,
          routes: {
            HomePage.id: (context) => Center(child: HomePage()),
            Dashboard.id: (context) => Dashboard(),
            Calculator.id: (context) => Calculator(),
            Profile.id: (context) => Profile(),
            Sip.id: (context) => Sip(),
            Cagr.id: (context) => Cagr(),
            Emi.id: (context) => Emi(),
            Currency.id: (context) => Currency(),
          },
        );
      }),
    );
  }
}
