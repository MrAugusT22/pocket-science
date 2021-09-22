import 'package:fin_calc/screens/home.dart';
import 'package:fin_calc/screens/welcome_screen.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const String id = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: InvestmentCardText(text: 'Error Occured'),
          );
        } else {
          return WelcomeScreen();
        }
      },
    );
  }
}
