import 'package:fin_calc/models/button.dart';
import 'package:fin_calc/screens/home.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/dialogbox.dart';
import 'package:fin_calc/utilities/errors.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  late TextEditingController _textEditingController1;
  late TextEditingController _textEditingController2;

  bool showSpinner = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController1 = TextEditingController();
    _textEditingController2 = TextEditingController();
  }

  void signUp() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        setState(() {
          showSpinner = false;
        });
        Navigator.pushNamed(context, HomePage.id);
        print('user created');
      }
    } catch (e) {
      print(e);
      ShowDialogBox showDialogBox = ShowDialogBox(
        context: context,
        actionButtonText: 'OK',
        msg: 'Email Id already taken 🙁',
        title: 'Error',
        delete: false,
        onPressed: () {
          Navigator.pop(context);
        },
      );
      await showDialogBox.showDialogBox();
      print(Errors.show(e.toString()));
    }
  }

  void signIn() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        setState(() {
          showSpinner = false;
        });
        Navigator.pushNamed(context, HomePage.id);
        print('user sign in');
      }
    } catch (e) {
      ShowDialogBox showDialogBox = ShowDialogBox(
        context: context,
        actionButtonText: 'OK',
        msg: 'Email Id already taken 🙁',
        title: 'Error',
        delete: false,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      Color kMyColor = myThemeData.getMyColor;
      InputDecoration kTextFieldDecoration = myThemeData.getTextFieldDecoration;
      bool formComplete = false;

      void getStarted() async {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          isScrollControlled: true,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: InvestmentCardText(
                            text: 'Sign In/Up',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(fontSize: 20),
                          controller: _textEditingController1,
                          maxLines: null,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              kTextFieldDecoration.copyWith(hintText: 'Email'),
                          onChanged: (value) {
                            setState(() {
                              formComplete =
                                  _textEditingController1.text.isNotEmpty &&
                                      _textEditingController2.text.isNotEmpty;
                              email = value;
                              print(value);
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          obscureText: true,
                          style: TextStyle(fontSize: 20),
                          controller: _textEditingController2,
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Password'),
                          onChanged: (value) {
                            setState(() {
                              formComplete =
                                  _textEditingController1.text.isNotEmpty &&
                                      _textEditingController2.text.isNotEmpty;
                              password = value;
                              print(value);
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Button(
                                text: 'Sign Up',
                                textSize: 20.0,
                                onPressed: () async {
                                  if (formComplete) {
                                    _textEditingController1.clear();
                                    _textEditingController2.clear();
                                    signUp();
                                  }
                                },
                                color: formComplete
                                    ? kMyColor
                                    : _isDarkMode
                                        ? kMyDarkBGColor
                                        : kMyLightBGColor,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Button(
                                text: 'Sign In',
                                textSize: 20.0,
                                onPressed: () async {
                                  if (formComplete) {
                                    _textEditingController1.clear();
                                    _textEditingController2.clear();
                                    signIn();
                                  }
                                },
                                color: formComplete
                                    ? kMyColor
                                    : _isDarkMode
                                        ? kMyDarkBGColor
                                        : kMyLightBGColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }

      return ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: kMyColor,
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 0.6 * MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xfff6c8d7),
                    ),
                  ),
                  Positioned(
                    left: (MediaQuery.of(context).size.width / 2) - 80,
                    top: (MediaQuery.of(context).size.width / 2) - 120,
                    height: 100,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/pigmoney1.jpg')),
                      ),
                    ),
                  ),
                  Positioned(
                    right: (MediaQuery.of(context).size.width / 2) - 60,
                    top: (MediaQuery.of(context).size.width / 2) - 100,
                    height: 100,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/pigmoney2.jpg')),
                      ),
                    ),
                  ),
                  Positioned(
                    right: (MediaQuery.of(context).size.width / 2) - 75,
                    bottom: (MediaQuery.of(context).size.width / 2) - 100,
                    height: 150,
                    width: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/pigmoney3.jpg')),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Button(
                text: 'Get Started',
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  getStarted();
                },
                color: Colors.blue,
              ),
              Button(
                text: 'Get Started',
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  getStarted();
                },
                color: Color(0xffF6C8D7),
              ),
            ],
          ),
        ),
      );
    });
  }
}
