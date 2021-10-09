import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_calc/models/button.dart';
import 'package:fin_calc/screens/sip.dart';
import 'package:fin_calc/services/firebase_services.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/dialogbox.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:fin_calc/utilities/transaction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);
  static const String id = 'expenses';

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final firestore = FirebaseFirestore.instance;

  late TextEditingController _textEditingController1;
  late TextEditingController _textEditingController2;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController1 = TextEditingController();
    _textEditingController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;

      List _purchaseTypes = myThemeData.getPurchaseTypes;

      List _transactionTypes = myThemeData.getTransactionTypesList;

      String purchaseType = 'Food';
      String transactionType = 'Debit';

      double _amt = 0.0;
      String _title = '';

      bool formComplete = false;

      Color kMyColor = myThemeData.getMyColor;

      InputDecoration kTextFieldDecoration = myThemeData.getTextFieldDecoration;

      String uid = myThemeData.getUserData[3];
      FirebaseService firebaseService =
          FirebaseService(uid: uid, context: context);

      void addTransaction() async {
        if (formComplete) {
          ShowDialogBox showDialogBox = ShowDialogBox(
              context: context,
              actionButtonText: 'Add',
              msg: 'Are you sure want to add transaction?',
              title: 'Confirm?',
              delete: false,
              onPressed: () {
                Provider.of<UserData>(context, listen: false)
                    .updateCancel(false);
                Navigator.of(context).pop();
              });
          await showDialogBox.showDialogBox();
          if (!myThemeData.getCancelStatus) {
            firebaseService.addTransactionData(
                amt: _amt,
                title: _title,
                debit: transactionType == 'Debit' ? true : false,
                purchaseType: purchaseType,
                date: selectedDate);
            Navigator.pop(context);
            _textEditingController1.clear();
            _textEditingController2.clear();
          }
          formatDate(DateTime.now());
        }
      }

      void onAddTap() {
        formatDate(DateTime.now());
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          isScrollControlled: true,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: InvestmentCardText(
                            text: 'Add Transactions',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(fontSize: 20),
                          textCapitalization: TextCapitalization.sentences,
                          controller: _textEditingController1,
                          maxLines: null,
                          decoration:
                              kTextFieldDecoration.copyWith(hintText: 'Title'),
                          onChanged: (value) {
                            setState(() {
                              formComplete =
                                  _textEditingController1.text.isNotEmpty &&
                                      _textEditingController2.text.isNotEmpty;
                              _title = value;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: purchaseType,
                                icon: const Icon(Icons.arrow_downward),
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
                                    print(newValue);
                                  });
                                },
                                items: _purchaseTypes
                                    .map<DropdownMenuItem<String>>((value) {
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
                                icon: const Icon(Icons.arrow_downward),
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
                                    .map<DropdownMenuItem<String>>((value) {
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
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime(2101));
                                if (picked != null && picked != selectedDate)
                                  setState(() {
                                    selectedDate = picked;
                                    formatDate(selectedDate);
                                    mon = mon;
                                    date = date;
                                  });
                              },
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.calendar),
                                  SizedBox(width: 10),
                                  InvestmentCardText(
                                    text: "$mon, $date",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(),
                                style: TextStyle(fontSize: 20),
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: _textEditingController2,
                                maxLines: null,
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Amt'),
                                onChanged: (value) {
                                  // newCommand = value;
                                  setState(() {
                                    formComplete = _textEditingController1
                                            .text.isNotEmpty &&
                                        _textEditingController2.text.isNotEmpty;
                                    _amt = double.parse(value);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Button(
                          text: 'Add',
                          onPressed: () {
                            addTransaction();
                          },
                          color: formComplete
                              ? kMyColor
                              : _isDarkMode
                                  ? kMyDarkBGColor
                                  : kMyLightBGColor,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }

      late List _transactionList;

      Stream<QuerySnapshot<Object?>> transactionStream = firestore
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .orderBy('date', descending: true)
          .snapshots();

      formatDate(DateTime.now());

      return Scaffold(
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
          child: Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: transactionStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final transactions = snapshot.data!.docs;

                    if (transactions.isEmpty) {
                      return Center(
                        child: Icon(
                          Icons.add_circle_outline_rounded,
                          size: 120,
                          color: _isDarkMode ? Colors.white12 : Colors.black26,
                        ),
                      );
                    } else {
                      _transactionList =
                          transactions.map((DocumentSnapshot doc) {
                        Map<String, dynamic> data =
                            doc.data()! as Map<String, dynamic>;
                        return TransactionCard(
                            amt: data['amt'],
                            date: data['date'],
                            debit: data['debit'],
                            title: data['title'],
                            type: data['purchaseType']);
                      }).toList();

                      return ListView.separated(
                        padding: EdgeInsets.only(bottom: 156, top: 30),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        physics: BouncingScrollPhysics(),
                        itemCount: _transactionList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              alignment: AlignmentDirectional.centerStart,
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            confirmDismiss: (DismissDirection direction) async {
                              return await ShowDialogBox(
                                  context: context,
                                  actionButtonText: 'Delete',
                                  msg:
                                      'Are you sure want to delete this message?',
                                  title: 'Delete',
                                  delete: true,
                                  index: index,
                                  onPressed: () async {
                                    await firestore.runTransaction(
                                        (Transaction myTransaction) async {
                                      await myTransaction.delete(
                                          transactions[index].reference);
                                    });
                                    Navigator.of(context).pop();
                                  }).showDialogBox();
                            },
                            onDismissed: (direction) {},
                            child: _transactionList[index],
                          );
                        },
                      );
                    }
                  }),
              Positioned(
                bottom: 70,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    print(mon);
                    print(monYr);
                    print('hello');
                    onAddTap();
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
