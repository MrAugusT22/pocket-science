import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';

class InvestmentData {
  final amtType;
  final amt;
  InvestmentData({this.amt, this.amtType});
}

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({
    Key? key,
    required TooltipBehavior tooltipBehavior,
    required this.res,
    required List<InvestmentData> chartData,
  })  : _tooltipBehavior = tooltipBehavior,
        _chartData = chartData,
        super(key: key);

  final TooltipBehavior _tooltipBehavior;
  final String res;
  final List<InvestmentData> _chartData;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      return SfCircularChart(
        tooltipBehavior: _tooltipBehavior,
        palette: [Colors.blue, _isDarkMode ? kMyLightBGColor : kMyDarkBGColor],
        annotations: [
          CircularChartAnnotation(
            widget: InvestmentCardText(text: '₹ $res'),
          )
        ],
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
            dataSource: _chartData,
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
