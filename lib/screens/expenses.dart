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
      return Scaffold(
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 5);
              },
              physics: BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    child: ExpansionPanelList(
                      expansionCallback: (i, isOpen) {
                        setState(() {
                          _isOpen[i] = !_isOpen[i];
                        });
                      },
                      elevation: 0,
                      dividerColor: kMyColor,
                      children: [
                        ExpansionPanel(
                          isExpanded: _isOpen[0],
                          canTapOnHeader: true,
                          backgroundColor: Colors.transparent,
                          headerBuilder: (context, open) {
                            return TransactionCard(
                              amt: 1500,
                              bank: 'SBI',
                              title:
                                  'Net Banking errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr',
                              date: '15 Sept 2021',
                              debit: false,
                            );
                          },
                          body: AdditionalDataCard(
                            title: '1 dozen eggs',
                            info: '',
                            elevation: 0.0,
                          ),
                        ),
                        ExpansionPanel(
                          isExpanded: _isOpen[1],
                          canTapOnHeader: true,
                          backgroundColor: Colors.transparent,
                          headerBuilder: (context, open) {
                            return TransactionCard(
                              amt: 150,
                              bank: 'SBI',
                              title: 'Net Banking',
                              date: '15 Sept 2021',
                              debit: true,
                            );
                          },
                          body: AdditionalDataCard(
                            title: '1 dozen eggs',
                            info: '',
                            elevation: 0.0,
                          ),
                        ),
                        ExpansionPanel(
                          isExpanded: _isOpen[2],
                          canTapOnHeader: true,
                          backgroundColor: Colors.transparent,
                          headerBuilder: (context, open) {
                            return TransactionCard(
                              amt: 2000,
                              bank: 'SBI',
                              title: 'Net Banking',
                              date: '15 Sept 2021',
                              debit: false,
                            );
                          },
                          body: AdditionalDataCard(
                            title: '1 dozen eggs',
                            info: '',
                            elevation: 0.0,
                          ),
                        ),
                        ExpansionPanel(
                          isExpanded: _isOpen[3],
                          canTapOnHeader: true,
                          backgroundColor: Colors.transparent,
                          headerBuilder: (context, open) {
                            return TransactionCard(
                              amt: 1500,
                              bank: 'SBI',
                              title: 'Net Banking',
                              date: '15 Sept 2021',
                              debit: false,
                            );
                          },
                          body: AdditionalDataCard(
                            elevation: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}
