import 'dart:io';
import 'package:fin_calc/utilities/additional_info_card.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:fin_calc/utilities/transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);
  static const String id = 'expenses';

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<bool> _isOpen = [true, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      int count = Transactions().getTransactionListCount;
      List<TransactionCard> _transactionList = Transactions().getTransactions;
      return Scaffold(
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 5);
              },
              physics: BouncingScrollPhysics(),
              itemCount: count,
              itemBuilder: (context, index) {
                return _transactionList[index];
              }),
        ),
      );
    });
  }
}
