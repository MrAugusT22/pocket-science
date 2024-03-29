import 'package:fin_calc/utilities/doughnut_chart.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/calculations.dart';
import 'package:provider/provider.dart';
import 'package:fin_calc/utilities/additional_info_card.dart';

class Emi extends StatefulWidget {
  const Emi({Key? key}) : super(key: key);
  static const String id = 'emi';

  @override
  _EmiState createState() => _EmiState();
}

class _EmiState extends State<Emi> {
  double p = 10;
  double r = 7.5;
  double t = 5;
  double emi = 0;
  String emi1 = '';
  double i = 0;
  String interest = '';
  String totAmt = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  void update() {
    emi = emiCalculate(p, r, t);
    emi1 = format(emi, 2);
    i = (emi * 12 * t) - (p * 100000);
    interest = format(i, 2);
    totAmt = format((p * 100000 + i), 2);
  }

  List<InvestmentData> getChartData() {
    List<InvestmentData> chartData = [
      InvestmentData(amtType: 'Principal', amt: (p * 100000)),
      InvestmentData(amtType: 'Interest', amt: i),
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, myThemeData, child) {
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InvestmentCardText(
                            text: 'Loan Amt',
                          ),
                          InvestmentCardText(
                            text: '₹ ${p.ceil().toInt()} L',
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
                          inactiveTickMarkColor: Colors.transparent,
                          valueIndicatorColor: kMyColor,
                          thumbColor: kMyColor,
                          overlayColor: kMyColor.withAlpha(32),
                        ),
                        child: Slider(
                          label: '${p.toInt()}',
                          divisions: 199,
                          min: 1,
                          max: 200,
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
                            text: 'Interest Rate',
                          ),
                          InvestmentCardText(
                            text: '$r %',
                          ),
                        ],
                      ),
                      //Expected interest
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: kMyColor,
                          inactiveTrackColor:
                          _isDarkMode ? Colors.white12 : Colors.black12,
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 4.0,
                          inactiveTickMarkColor: Colors.transparent,
                          valueIndicatorColor: kMyColor,
                          thumbColor: kMyColor,
                          overlayColor: kMyColor.withAlpha(32),
                        ),
                        child: Slider(
                          label: '$r',
                          divisions: 60,
                          min: 5,
                          max: 20,
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
                      InvestmentCardText(text: 'EMI: ₹ $emi1'),
                      SizedBox(height: 20),
                      DoughnutChart(
                        initialAmt: p*100000,
                        initailAmtText: 'Principle',
                        interest: i,
                        interestText: 'Interest',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                AdditionalDataCard(
                  elevation: 5.0,
                  title: 'EMI',
                  info:
                      'An equated monthly installment (EMI) is a fixed payment amount made by a borrower to a lender at a specified date each calendar month. Equated monthly installments are applied to both interest and principal each month so that over a specified number of years, the loan is paid off in full. In the most common types of loans—such as real estate mortgages, auto loans, and student loans—the borrower makes fixed periodic payments to the lender over the course of several years with the goal of retiring the loan.',
                ),
              ],
            ),
          );
        }
      );
    });
  }
}
