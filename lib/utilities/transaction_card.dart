import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  final debit;
  final title;
  final bank;
  final date;
  final amt;
  TransactionCard({
    @required this.amt,
    @required this.bank,
    @required this.date,
    @required this.debit,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      return Container(
        decoration: BoxDecoration(
          color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(
              debit
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              color: Colors.white,
            ),
            backgroundColor: debit ? Colors.red : Colors.green,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InvestmentCardText(text: title),
              InvestmentCardText(text: bank, fontWeight: FontWeight.normal),
              InvestmentCardText(
                  text: '$date',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal),
            ],
          ),
          trailing: InvestmentCardText(text: '${debit ? '-' : ''}₹$amt'),
        ),
      );
    });
  }
}
