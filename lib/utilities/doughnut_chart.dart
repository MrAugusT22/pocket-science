import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class InvestmentData {
  final amtType;
  final amt;
  InvestmentData({this.amt, this.amtType});
}

class DoughnutChart extends StatelessWidget {
  DoughnutChart({
    this.chartData,
    this.tooltipBehavior,
    this.res,
    this.centerTexts
  });

  final tooltipBehavior;
  final res;
  final chartData;
  final centerTexts;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      Color kMyColor = myThemeData.getMyColor;

      return SfCircularChart(
        tooltipBehavior: tooltipBehavior,
        palette: [kMyColor, _isDarkMode ? kMyLightBGColor : kMyDarkBGColor],
        annotations: centerTexts,
        legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? kMyLightBGColor : kMyDarkBGColor,
          ),
          position: LegendPosition.bottom,
        ),
        series: [
          DoughnutSeries<InvestmentData, String>(
            dataSource: chartData,
            xValueMapper: (InvestmentData data, _) => data.amtType,
            yValueMapper: (InvestmentData data, _) => data.amt,
            enableTooltip: true,
            explode: true,
            explodeIndex: 1,
            innerRadius: '80%',
            cornerStyle: CornerStyle.bothCurve,
          )
        ],
      );
    });
  }
}
