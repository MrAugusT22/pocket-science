import 'dart:math';
import 'package:fin_calc/models/button.dart';
import 'package:fin_calc/utilities/doughnut_chart.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/calculations.dart';
import 'package:provider/provider.dart';
import 'package:fin_calc/utilities/additional_info_card.dart';

enum Mode { sip, cagr }

class Sip extends StatefulWidget {
  const Sip({Key? key}) : super(key: key);
  static const String id = 'sip';

  @override
  _SipState createState() => _SipState();
}

class _SipState extends State<Sip> {
  double i = 6;
  double p = 5000;
  double r = 10;
  double t = 5;
  double inv = 0;
  double amt = 0;
  String investment = '';
  double ret = 0;
  String returns = '';
  String res = '';

  double inflationAmt = 0;
  String inflationAmt1 = '';

  Mode selectedMode = Mode.sip;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  void update() {
    bool sip = selectedMode == Mode.sip ? true : false;
    if (sip) {
      inv = p * t * 12;
      amt = sipCalculate(p, r, t, sip);
      ret = amt - inv;
      res = format(amt, 2);
      investment = format(inv, 2);
      returns = format(ret, 2);
      inflationAmt = amt * pow((1 + i / 100), t * (-1)).toDouble();
      inflationAmt1 = format(inflationAmt, 2);
    } else {
      inv = p;
      amt = sipCalculate(p, r, t, sip);
      ret = amt - inv;
      res = format(amt, 2);
      investment = format(inv, 2);
      returns = format(ret, 2);
      inflationAmt = amt * pow((1 + 6 / 100), t * (-1)).toDouble();
      inflationAmt1 = format(inflationAmt, 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, myThemeData, child) {
        bool _isDarkMode = myThemeData.getDarkMode;
        Color kMyColor = myThemeData.getMyColor;

        return ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: 5);
          },
          physics: BouncingScrollPhysics(),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Button(
                                text: 'SIP',
                                onPressed: () {
                                  setState(() {
                                    selectedMode = Mode.sip;
                                    update();
                                  });
                                },
                                textSize: 15.0,
                                arrow: false,
                                center: true,
                                buttonColor: selectedMode == Mode.sip
                                    ? kMyColor
                                    : _isDarkMode
                                        ? kMyDarkBGColor
                                        : kMyLightBGColor,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Button(
                                text: 'Lumpsump',
                                onPressed: () {
                                  setState(() {
                                    selectedMode = Mode.cagr;
                                    update();
                                  });
                                },
                                textSize: 15.0,
                                arrow: false,
                                center: true,
                                buttonColor: selectedMode == Mode.cagr
                                    ? kMyColor
                                    : _isDarkMode
                                        ? kMyDarkBGColor
                                        : kMyLightBGColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InvestmentCardText(
                              text:
                                  '${selectedMode == Mode.sip ? 'Monthly SIP' : 'Total Investment'}',
                            ),
                            InvestmentCardText(
                              text: '₹ ${p.ceil().toInt()}',
                            ),
                          ],
                        ),
                        //Monthly SIP
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: kMyColor,
                            inactiveTrackColor:
                                _isDarkMode ? Colors.white12 : Colors.black12,
                            trackShape: RoundedRectSliderTrackShape(),
                            trackHeight: 4.0,
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            valueIndicatorColor: kMyColor,
                            thumbColor: kMyColor,
                            overlayColor: kMyColor.withAlpha(32),
                          ),
                          child: Slider(
                            label: '${p.toInt()}',
                            divisions: 199,
                            min: 1000,
                            max: 200000,
                            value: p,
                            onChanged: (value) {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                print(value);
                                p = value;
                                print(value);
                                update();
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InvestmentCardText(
                              text: 'Expected Returns',
                            ),
                            InvestmentCardText(
                              text: '${r.ceil().toInt()} %',
                            ),
                          ],
                        ),
                        //Expected Returns
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: kMyColor,
                            inactiveTrackColor:
                                _isDarkMode ? Colors.white12 : Colors.black12,
                            trackShape: RoundedRectSliderTrackShape(),
                            trackHeight: 4.0,
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            valueIndicatorColor: kMyColor,
                            thumbColor: kMyColor,
                            overlayColor: kMyColor.withAlpha(32),
                          ),
                          child: Slider(
                            label: '${r.toInt()}',
                            divisions: 29,
                            min: 1,
                            max: 30,
                            value: r,
                            onChanged: (value) {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                print(value);
                                r = value;
                                print(value);
                                update();
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InvestmentCardText(
                              text: 'Time Period',
                            ),
                            InvestmentCardText(
                              text: '${t.ceil().toInt()} Yr',
                            ),
                          ],
                        ),
                        //Time Period
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: kMyColor,
                            inactiveTrackColor:
                                _isDarkMode ? Colors.white12 : Colors.black12,
                            trackShape: RoundedRectSliderTrackShape(),
                            trackHeight: 4.0,
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            valueIndicatorColor: kMyColor,
                            thumbColor: kMyColor,
                            overlayColor: kMyColor.withAlpha(32),
                          ),
                          child: Slider(
                            label: '${t.toInt()}',
                            divisions: 29,
                            min: 1,
                            max: 30,
                            value: t,
                            onChanged: (value) {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                print(value);
                                t = value;
                                print(value);
                                update();
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        DoughnutChart(
                          interest: ret,
                          interestText: 'Returns',
                          initialAmt: inv,
                          initailAmtText: 'Invested',
                        ),
                        SizedBox(height: 20),
                        // Inflation
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InvestmentCardText(
                              text: 'Inflation',
                            ),
                            InvestmentCardText(
                              text: '$i %',
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: kMyColor,
                            inactiveTrackColor:
                                _isDarkMode ? Colors.white12 : Colors.black12,
                            trackShape: RoundedRectSliderTrackShape(),
                            trackHeight: 4.0,
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            valueIndicatorColor: kMyColor,
                            thumbColor: kMyColor,
                            overlayColor: kMyColor.withAlpha(32),
                          ),
                          child: Slider(
                            label: '$i',
                            divisions: 18,
                            min: 1,
                            max: 10,
                            value: i,
                            onChanged: (value) {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                print(value);
                                i = value;
                                print(value);
                                update();
                              });
                            },
                          ),
                        ),
                        InvestmentCardText(
                            text: 'Adjusted Amt: ₹ $inflationAmt1'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  AdditionalDataCard(
                    elevation: 5.0,
                    title: 'SIP',
                    info:
                        'A Systematic Investment Plan (or SIP) is an investment mode through which you can invest in mutual funds. As the term indicates, it is a systematic method of investing fixed amounts of money periodically. This can be monthly, quarterly or semi-annually etc.',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// elevation: 5,
// borderRadius: BorderRadius.circular(20),
// color: Colors.transparent,
