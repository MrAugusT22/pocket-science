import 'package:fin_calc/screens/cagr.dart';
import 'package:fin_calc/screens/emi.dart';
import 'package:fin_calc/screens/sip.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);
  static const String id = 'calculator';

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<bool> _isOpen = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, myThemeData, child) {
        Color kMyColor = myThemeData.getMyColor;
        
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
            child: ListView.separated(
              // padding: EdgeInsets.all(0),
              separatorBuilder: (context, index) {
                return SizedBox(height: 5);
              },
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kMyColor,
                    ),
                    child: ExpansionPanelList(
                      expansionCallback: (i, isOpen) {
                        setState(() {
                          _isOpen[i] = !_isOpen[i];
                        });
                      },
                      elevation: 0,
                      dividerColor: Colors.transparent,
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, open) {
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                'SIP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          body: Sip(),
                          isExpanded: _isOpen[0],
                          canTapOnHeader: true,
                          backgroundColor: Colors.transparent,
                        ),
                        ExpansionPanel(
                          headerBuilder: (context, open) {
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                'CAGR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          body: Cagr(),
                          isExpanded: _isOpen[1],
                          canTapOnHeader: true,
                          backgroundColor: Colors.transparent,
                        ),
                        ExpansionPanel(
                          headerBuilder: (context, open) {
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                'EMI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'RobotoMono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          body: Emi(),
                          isExpanded: _isOpen[2],
                          canTapOnHeader: true,
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 1,
            ),
          ),
        );
      }
    );
  }
}
