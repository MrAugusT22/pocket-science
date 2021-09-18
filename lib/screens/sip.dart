import 'package:fin_calc/models/button.dart';
import 'package:fin_calc/utilities/doughnut_chart.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/calculations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fin_calc/utilities/additional_info_card.dart';

enum Mode { sip, cagr }

class Sip extends StatefulWidget {
  const Sip({Key? key}) : super(key: key);
  static const String id = 'sip';

  @override
  _SipState createState() => _SipState();
}

class _SipState extends State<Sip> {
  double p = 5000;
  double r = 10;
  double t = 5;
  double inv = 0;
  double amt = 0;
  String investment = '';
  double ret = 0;
  String returns = '';
  String res = '';
  Mode selectedMode = Mode.sip;
  List<InvestmentData> _chartData = [];
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
    _tooltipBehavior = TooltipBehavior(enable: true);
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
    } else {
      inv = p;
      amt = sipCalculate(p, r, t, sip);
      ret = amt - inv;
      res = format(amt, 2);
      investment = format(inv, 2);
      returns = format(ret, 2);
    }
    _chartData = getChartData();
  }

  List<InvestmentData> getChartData() {
    List<InvestmentData> chartData = [
      InvestmentData(amtType: 'Initial Amt', amt: inv),
      InvestmentData(amtType: 'Returns', amt: ret),
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      Color kMyColor = myThemeData.getMyColor;

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
                            color: selectedMode == Mode.sip
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
                            color: selectedMode == Mode.cagr
                                ? kMyColor
                                : _isDarkMode
                                    ? kMyDarkBGColor
                                    : kMyLightBGColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                            _isDarkMode ? Colors.white12 : Colors.black54,
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
                        divisions: 399,
                        min: 500,
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
                            _isDarkMode ? Colors.white12 : Colors.black54,
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
                            _isDarkMode ? Colors.white12 : Colors.black54,
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
                        tooltipBehavior: _tooltipBehavior,
                        res: res,
                        chartData: _chartData)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            AdditionalDataCard(
              // elevation: 5.0,
              title: 'SIP?',
              info:
                  'A Systematic Investment Plan (or SIP) is an investment mode through which you can invest in mutual funds. As the term indicates, it is a systematic method of investing fixed amounts of money periodically. This can be monthly, quarterly or semi-annually etc.',
            ),
          ],
        ),
      );
    });
  }
}
