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
      return ClipPath(
        clipper: ShapeBorderClipper(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        )
    ),
        child: Container(
          decoration: BoxDecoration(
            color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor,
            borderRadius: BorderRadius.circular(20),
            border: Border(
                left: BorderSide(
                    color: debit ? Colors.red : Colors.green,
                    width: 7.0
                )
            )
          ),
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(
                debit ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
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
            trailing: InvestmentCardText(text: '${debit ? '-' : ''}₹$amt', fontStyle: FontStyle.italic,),
          ),
        ),
      );
    });
  }
}

class Transactions {
  List<TransactionCard> _transactionList = [
    TransactionCard(
      amt: 1500,
      bank: 'SBI',
      title: 'Net Banking errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr',
      date: '15 Sept 2021',
      debit: false,
    ),
    TransactionCard(
      amt: 150,
      bank: 'SBI',
      title: 'Net Banking',
      date: '15 Sept 2021',
      debit: true,
    ),
    TransactionCard(
      amt: 2000,
      bank: 'SBI',
      title: 'Net Banking',
      date: '15 Sept 2021',
      debit: false,
    ),
    TransactionCard(
      amt: 1500,
      bank: 'SBI',
      title: 'Net Banking',
      date: '15 Sept 2021',
      debit: false,
    ),
  ];

  void addTransaction(
      double amt, String bank, String date, bool debit, String title) {
    _transactionList.add(
      TransactionCard(
        amt: amt,
        bank: bank,
        date: date,
        debit: debit,
        title: title,
      ),
    );
  }

  int get getTransactionListCount {
    return _transactionList.length;
  }

  List<TransactionCard> get getTransactions {
    return _transactionList;
  }
}
