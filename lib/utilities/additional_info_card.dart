import 'package:fin_calc/utilities/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:provider/provider.dart';

class AdditionalDataCard extends StatelessWidget {
  final title;
  final info;
  AdditionalDataCard({@required this.title, @required this.info});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      return Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  InvestmentCardText(
                    text: title,
                    fontSize: 20.0,
                  ),
                ],
              ),
              SizedBox(height: 10),
              InvestmentCardText(
                text: info,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
      );
    });
  }
}
