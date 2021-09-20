import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:provider/provider.dart';

class AdditionalDataCard extends StatelessWidget {
  final title;
  final info;
  final elevation;
  final transaction;
  AdditionalDataCard(
      {this.title = '',
      this.info = '',
      this.elevation = 5.0,
      this.transaction = false});

  @override
  Widget build(BuildContext context) {
    bool noInfo = false;
    bool noTitle = false;
    if (info == '') {
      noInfo = true;
    }
    if (title == '') {
      noTitle = true;
    }

    return Consumer<UserData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      return Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: transaction
                  ? Colors.transparent
                  : _isDarkMode
                      ? kMyDarkBGColor
                      : kMyLightBGColor),
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
                    text: '${noTitle ? 'No info' : title}',
                  ),
                ],
              ),
              SizedBox(height: 10),
              noInfo
                  ? InvestmentCardText(
                      text: 'No info!',
                      fontWeight: FontWeight.normal,
                    )
                  : InvestmentCardText(
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
