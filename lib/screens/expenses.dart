import 'package:fin_calc/models/button.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/theme_data.dart';
import 'package:fin_calc/utilities/transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);
  static const String id = 'expenses';

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<bool> _isOpen = [true, false, false, false];

  late TextEditingController _textEditingController1;
  late TextEditingController _textEditingController2;
  late TextEditingController _textEditingController3;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController1 = TextEditingController();
    _textEditingController2 = TextEditingController();
    _textEditingController3 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;

      List<TransactionCard> _transactionList = myThemeData.getTransactions;
      int count = _transactionList.length;
      List _purchaseTypes = myThemeData.getPurchaseTypes;

      List _transactionTypes = myThemeData.getTransactionTypesList;

      String purchaseType = 'Food';
      String transactionType = 'Credit';

      double _amt = 0.0;
      String _title = '';

      return Scaffold(
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
          child: Stack(
            children: [
              ListView.separated(
                padding: EdgeInsets.only(bottom: 156, top: 30),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 5);
                },
                physics: BouncingScrollPhysics(),
                itemCount: count,
                itemBuilder: (context, index) {
                  return _transactionList[index];
                },
              ),
              Positioned(
                bottom: 70,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => StatefulBuilder(
                        builder: (context, setState) {
                          return SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30)),
                                    color: _isDarkMode
                                        ? kMyDarkBGColor
                                        : kMyLightBGColor),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Add Transaction',
                                      style: TextStyle(
                                          fontFamily: 'RobotoMono',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      style: TextStyle(fontSize: 20),
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: _textEditingController1,
                                      maxLines: null,
                                      decoration: kTextFieldDecoration.copyWith(
                                          hintText: 'Title'),
                                      onChanged: (value) {
                                        // newCommand = value;
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: purchaseType,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            iconSize: 24,
                                            elevation: 16,
                                            style: TextStyle(
                                              fontFamily: 'RobotoMono',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              color: _isDarkMode
                                                  ? kMyLightBGColor
                                                  : kMyDarkBGColor,
                                            ),
                                            underline: Container(
                                              height: 2,
                                              color: kMyColor,
                                            ),
                                            onChanged: (newValue) {
                                              setState(() {
                                                purchaseType = newValue!;
                                              });
                                            },
                                            items: _purchaseTypes
                                                .map<DropdownMenuItem<String>>(
                                                    (value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: transactionType,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            iconSize: 24,
                                            elevation: 16,
                                            style: TextStyle(
                                              fontFamily: 'RobotoMono',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              color: _isDarkMode
                                                  ? kMyLightBGColor
                                                  : kMyDarkBGColor,
                                            ),
                                            underline: Container(
                                              height: 2,
                                              color: kMyColor,
                                            ),
                                            onChanged: (newValue) {
                                              setState(() {
                                                transactionType = newValue!;
                                              });
                                            },
                                            items: _transactionTypes
                                                .map<DropdownMenuItem<String>>(
                                                    (value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: selectedDate,
                                                    firstDate:
                                                        DateTime(2015, 8),
                                                    lastDate: DateTime(2101));
                                            if (picked != null &&
                                                picked != selectedDate)
                                              setState(() {
                                                selectedDate = picked;
                                              });
                                          },
                                          child: InvestmentCardText(
                                            text: "${selectedDate.toLocal()}"
                                                .split(' ')[0],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextField(
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            style: TextStyle(fontSize: 20),
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            controller: _textEditingController2,
                                            maxLines: null,
                                            decoration: kTextFieldDecoration
                                                .copyWith(hintText: 'Amt'),
                                            onChanged: (value) {
                                              // newCommand = value;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Button(
                                      text: 'Add',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Material(
                    elevation: 5,
                    shape: CircleBorder(),
                    child: Container(
                      constraints:
                          BoxConstraints.tightFor(width: 56, height: 56),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kMyColor,
                      ),
                      child: Icon(Icons.add_rounded, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
