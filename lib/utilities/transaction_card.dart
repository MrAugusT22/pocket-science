import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatefulWidget {
  final debit;
  final title;
  final date;
  final amt;
  final type;
  TransactionCard({
    @required this.amt,
    @required this.date,
    @required this.debit,
    @required this.title,
    @required this.type,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  Map _purchaseTypeList = {
    1: {'icon': Icons.breakfast_dining_rounded, 'info': 'Food'},
    2: {'icon': Icons.receipt_long_rounded, 'info': 'Bill'},
    3: {'icon': Icons.sync_rounded, 'info': 'Self Transfer'},
  };

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: widget.debit ? Colors.red : Colors.green,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(children: [
                    Icon(
                      _purchaseTypeList[widget.type]['icon'],
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InvestmentCardText(text: widget.title),
                          InvestmentCardText(
                            text: '${widget.date}',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal,
                            color:
                                _isDarkMode ? Colors.white60 : Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    InvestmentCardText(
                      text: '${widget.debit ? '-' : ''}₹${widget.amt}',
                      fontStyle: FontStyle.italic,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}