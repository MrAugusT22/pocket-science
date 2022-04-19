import 'package:fin_calc/models/blob.dart';
import 'package:fin_calc/screens/home.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(milliseconds: 5000);

  late AnimationController _rotationController;
  late AnimationController _scaleController;

  double _rotation = 0;
  double _scale = 0.85;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration);
    _rotationController.addListener(() {
      setState(() {
        _updateRotation();
      });
    });
    _rotationController.forward();
    _rotationController.repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration);
    _scaleController.addListener(() {
      setState(() {
        _updateScale();
      });
    });
    _scaleController.forward();
  }

  double pi = 22 / 7;

  void _updateRotation() {
    _rotation = (_rotationController.value * 2 * pi);
  }

  void _updateScale() => _scale = (_scaleController.value * 20) + 0.85;

  @override
  void dispose() {
    // TODO: implement dispose
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, myThemeData, child) {
      // bool _isDarkMode = myThemeData.getDarkMode;
      myThemeData.getAccentColor();
      Color kMyColor = myThemeData.getMyColor;
      // InputDecoration kTextFieldDecoration = myThemeData.getTextFieldDecoration;
      // bool formComplete = false;

      void getStarted() async {
        Navigator.pushNamed(context, HomePage.id);
      }

      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(150),
                    topRight: Radius.circular(240),
                    bottomLeft: Radius.circular(220),
                    bottomRight: Radius.circular(150),
                  ),
                  child: Blob(
                    color: kMyColor, // color blue
                    scale: _scale,
                    rotation: _rotation,
                  ),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height / 3) - 20,
                    ),
                    Material(
                      shape: CircleBorder(),
                      elevation: 5,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: kMyColor,
                        child: CircleAvatar(
                          radius: 78,
                          backgroundImage: AssetImage(kMyImage),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Pocket',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kMyColor.computeLuminance() > 0.5
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: 'RobotoMono',
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Science',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kMyColor.computeLuminance() > 0.5
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: 'RobotoMono',
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: NeumorphicButton(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  getStarted();
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  depth: 5,
                  lightSource: LightSource.topLeft,
                  color: kMyColor,
                  intensity: 0.2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InvestmentCardText(
                      text: 'Get Started',
                      color: kMyColor.computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                      fontSize: 30.0,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 40,
                      color: kMyColor.computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                    ),
                  ],
                ),
                // textColor:
              ),
            ),
          ],
        ),
      );
    });
  }
}

// if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: InvestmentCardText(text: 'Error Occured'));
//             } else if (snapshot.hasData) {
//               return HomePage();
//               // Navigator.pushNamed(context, HomePage.id);
//             }
