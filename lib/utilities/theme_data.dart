import 'package:fin_calc/utilities/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeData extends ChangeNotifier {
  late bool _isDarkMode;
  late ThemePreferences _themePreferences;

  MyThemeData() {
    _isDarkMode = true;
    _themePreferences = ThemePreferences();
    getPreferences();
  }

  List _purchaseTypeList = [
    'Food',
    'Travel',
    'Medicine',
    'Housing',
    'Personal',
    'Bill',
    'Self Transfer',
  ];

  List _transactionTypesList = [
    'Credit',
    'Debit',
  ];

  List<TransactionCard> _transactions = [];

  String mon = '';
  int date = 0;

  bool cancel = true;

  Color kMyColor = Colors.blue;

  InputDecoration get getTextFieldDecoration {
    return InputDecoration(
      hintStyle: TextStyle(fontFamily: "RobotoMono"),
      hintText: '',
      contentPadding: EdgeInsets.all(20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: kMyColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Color get getMyColor {
    return kMyColor;
  }

  void updateMyColor(Color color) {
    kMyColor = color;
    notifyListeners();
  }

  bool get getCancelStatus {
    return cancel;
  }

  void updateCancel(bool value) {
    cancel = value;
    notifyListeners();
  }

  void deleteTransaction(int index) {
    _transactions.removeAt(index);
    notifyListeners();
  }

  List get getDate {
    return [mon, date];
  }

  void formatDate(DateTime d) {
    var format = DateFormat('MMM');
    String date1 = format.format(d);
    mon = date1;
    var format2 = DateFormat('dd');
    String date2 = format2.format(d);
    int date3 = int.parse(date2);
    date = date3;
  }

  List get getPurchaseTypes {
    return _purchaseTypeList;
  }

  List get getTransactionTypesList {
    return _transactionTypesList;
  }

  List<TransactionCard> get getTransactions {
    return _transactions;
  }

  void addTransactions(TransactionCard transactionCard) {
    _transactions.add(transactionCard);
    notifyListeners();
  }

  void cancelTransaction() {
    _transactions.removeLast();
  }

  bool get getDarkMode {
    return _isDarkMode;
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _themePreferences.setTheme(_isDarkMode);
    notifyListeners();
  }

  void getPreferences() async {
    _isDarkMode = await _themePreferences.getTheme();
    notifyListeners();
  }
}

class ThemePreferences {
  static const PREF_KEY = "pref_key";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(PREF_KEY) ?? false;
  }
}
