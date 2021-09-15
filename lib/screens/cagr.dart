import 'package:fin_calc/utilities/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fin_calc/utilities/calculations.dart';
import 'package:fin_calc/models/button.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/investment_textfield.dart';
import 'package:fin_calc/utilities/additional_info_card.dart';
import 'package:provider/provider.dart';

enum Mode { total, cagr }

class Cagr extends StatefulWidget {
  const Cagr({Key? key}) : super(key: key);
  static const String id = 'cagr';

  @override
  _CagrState createState() => _CagrState();
}

class _CagrState extends State<Cagr> {
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();
  double p = 0;
  double a = 0;
  double t = 0;
  double inv = 0;
  String investment = '';
  double ret = 0;
  String returns = '';
  String res = '';
  Mode selectedMode = Mode.cagr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
    super.dispose();
  }

  void update() {
    setState(() {
      print('hii');
      bool cagr = selectedMode == Mode.cagr ? true : false;
      inv = p;
      double amt = cagrCalculate(p, a, t, cagr);
      ret = a - inv;
      res = amt.toStringAsFixed(2);
      res = '${res == 'NaN' ? '0' : '$res'}';
      investment = format(inv, 2);
      returns = format(ret, 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Button(
                            text: 'CAGR',
                            onPressed: () {
                              setState(() {
                                selectedMode = Mode.cagr;
                                update();
                              });
                            },
                            textSize: 15.0,
                            arrow: false,
                            center: true,
                            color: selectedMode == Mode.cagr
                                ? kMyColor
                                : kMyDarkBGColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Button(
                            text: 'NET',
                            onPressed: () {
                              setState(() {
                                selectedMode = Mode.total;
                                update();
                              });
                            },
                            textSize: 15.0,
                            arrow: false,
                            center: true,
                            color: selectedMode == Mode.total
                                ? kMyColor
                                : kMyDarkBGColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        InvestmentCardText(text: 'Investment: '),
                        InputTextField(
                          textEditingController: _textEditingController1,
                          hintText: '1000',
                          prefixText: '₹',
                          onChanged: (value) {
                            String x = value;
                            try {
                              p = double.parse(x);
                            } catch (e) {
                              p = 0;
                            }
                            update();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InvestmentCardText(text: 'Final Value: '),
                        InputTextField(
                          textEditingController: _textEditingController2,
                          hintText: '5000',
                          prefixText: '₹',
                          onChanged: (value) {
                            String x = value;
                            try {
                              a = double.parse(x);
                            } catch (e) {
                              a = 0;
                            }
                            update();
                          },
                        ),
                      ],
                    ),
                    selectedMode == Mode.cagr
                        ? Row(
                            children: [
                              InvestmentCardText(text: 'Time: '),
                              InputTextField(
                                textEditingController: _textEditingController3,
                                hintText: '2',
                                suffixText: 'YR',
                                onChanged: (value) {
                                  String x = value;
                                  try {
                                    t = double.parse(x);
                                  } catch (e) {
                                    t = 0;
                                  }
                                  print(t);
                                  update();
                                },
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(height: 10),
                    InvestmentCardText(text: 'Returns: ₹ $returns'),
                    SizedBox(height: 10),
                    InvestmentCardText(
                        text:
                            '${selectedMode == Mode.cagr ? 'CAGR: $res%' : 'Net Returns: $res%'}')
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            AdditionalDataCard(
              elevation: 5.0,
              title: 'CAGR?',
              info:
                  'The compound annual growth rate (CAGR) is the rate of return (RoR) that would be required for an investment to grow from its beginning balance to its ending balance, assuming the profits were reinvested at the end of each period of the investment’s life span.',
            ),
          ],
        ),
      );
    });
  }
}
