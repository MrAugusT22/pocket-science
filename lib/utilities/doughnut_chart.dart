import 'package:fin_calc/utilities/calculations.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

int touchedIndex = -1;

class InvestmentData {
  final amtType;
  final amt;
  InvestmentData({this.amt, this.amtType});
}

class DoughnutChart extends StatefulWidget {
  // DoughnutChart({
  //   this.chartData,
  //   this.tooltipBehavior,
  //   this.res,
  //   this.centerTexts
  // });
  //
  // final tooltipBehavior;
  // final res;
  // final chartData;
  // final centerTexts;

  final initialAmt;
  final interest;
  final initailAmtText;
  final interestText;

  DoughnutChart(
      {this.initialAmt, this.interest, this.initailAmtText, this.interestText});

  @override
  State<DoughnutChart> createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width - 120;
    String res = format(widget.interest + widget.initialAmt, 2);
    String iniData = format(widget.initialAmt, 2);
    String intData = format(widget.interest, 2);
    List<String> data = [
      res,
      iniData,
      intData,
    ];

    return Consumer<UserData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      Color kMyColor = myThemeData.getMyColor;

      List<PieChartSectionData> sections = [
        PieChartSectionData(
          value: widget.initialAmt,
          color: _isDarkMode ? kMyLightBGColor : kMyDarkBGColor,
          radius: touchedIndex == 0 ? 40 : 30,
          showTitle: false,
        ),
        PieChartSectionData(
          value: widget.interest,
          color: kMyColor,
          radius: touchedIndex == 1 ? 40 : 30,
          showTitle: false,
        ),
      ];

      return Column(
        children: [
          Material(
            elevation: 5,
            shape: CircleBorder(),
            color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor,
            child: Container(
              constraints: BoxConstraints.tightFor(
                height: radius,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sections: sections,
                      sectionsSpace: 5,
                      centerSpaceRadius:
                          MediaQuery.of(context).size.width / 2 - 100,
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          print('touched');
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                          print(touchedIndex);
                        });
                      }),
                    ),
                    swapAnimationDuration: Duration(milliseconds: 150),
                    swapAnimationCurve: Curves.linear,
                  ),
                  Material(
                    elevation: 5,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 2 - 100,
                      backgroundColor:
                          _isDarkMode ? kMyDarkBGColor : kMyLightBGColor,
                      child: InvestmentCardText(
                        text:
                            '${data[touchedIndex+1]}',
                        color: _isDarkMode ? kMyLightBGColor : kMyDarkBGColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: kMyColor, radius: 5),
                  SizedBox(width: 10),
                  InvestmentCardText(
                    text: widget.interestText,
                    fontStyle: FontStyle.italic,
                    fontSize: 10.0,
                  ),
                ],
              ),
              SizedBox(width: 40),
              Row(
                children: [
                  CircleAvatar(
                      backgroundColor:
                          _isDarkMode ? kMyLightBGColor : kMyDarkBGColor,
                      radius: 5),
                  SizedBox(width: 10),
                  InvestmentCardText(
                    text: widget.initailAmtText,
                    fontStyle: FontStyle.italic,
                    fontSize: 10.0,
                  ),
                ],
              ),
            ],
          ),
        ],
      );

      // return SfCircularChart(
      //   tooltipBehavior: tooltipBehavior,
      //   palette: [kMyColor, _isDarkMode ? kMyLightBGColor : kMyDarkBGColor],
      //   annotations: centerTexts,
      //   legend: Legend(
      //     isVisible: true,
      //     overflowMode: LegendItemOverflowMode.wrap,
      //     textStyle: TextStyle(
      //       fontFamily: 'RobotoMono',
      //       fontSize: 10,
      //       fontWeight: FontWeight.bold,
      //       color: _isDarkMode ? kMyLightBGColor : kMyDarkBGColor,
      //     ),
      //     position: LegendPosition.bottom,
      //   ),
      //   series: [
      //     DoughnutSeries<InvestmentData, String>(
      //       dataSource: chartData,
      //       xValueMapper: (InvestmentData data, _) => data.amtType,
      //       yValueMapper: (InvestmentData data, _) => data.amt,
      //       enableTooltip: true,
      //       explode: true,
      //       explodeIndex: 1,
      //       innerRadius: '80%',
      //       cornerStyle: CornerStyle.bothCurve,
      //     )
      //   ],
      // );
    });
  }
}
