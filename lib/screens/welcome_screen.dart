import 'package:fin_calc/models/blob.dart';
import 'package:fin_calc/models/button.dart';
import 'package:fin_calc/screens/home.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/dialogbox.dart';
import 'package:fin_calc/utilities/errors.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      setState(() {
        showSpinner = true;
        Center(
          child: CircularProgressIndicator(),
        );
      });
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
      Center(
        child: CircularProgressIndicator(),
      );
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
    return Consumer<UserData>(builder: (context, myThemeData, child) {
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
                                    Navigator.pop(context);
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
                                    Navigator.pop(context);
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
                        SizedBox(height: 10),
                        RawMaterialButton(
                          onPressed: () {
                            myThemeData.googleLogin();
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          fillColor: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kMyColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.google),
                                SizedBox(width: 10),
                                InvestmentCardText(
                                  text: 'Sign in with Google',
                                  fontSize: 20.0,
                                )
                              ],
                            ),
                          ),
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

      return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: InvestmentCardText(text: 'Error Occured'));
            } else if (snapshot.hasData) {
              return HomePage();
              // Navigator.pushNamed(context, HomePage.id);
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.only(
                        // topLeft: Radius.circular(150),
                        // topRight: Radius.circular(240),
                        bottomLeft: Radius.circular(220),
                        bottomRight: Radius.circular(150),
                      ),
                      child: Container(
                        height: 0.6 * MediaQuery.of(context).size.height,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Color(0xfff6c8d7),
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(150),
                            // topRight: Radius.circular(240),
                            bottomLeft: Radius.circular(220),
                            bottomRight: Radius.circular(150),
                          ),
                        ),
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Button(
                    text: 'Get Started',
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      getStarted();
                    },
                    color: Colors.blue,
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
