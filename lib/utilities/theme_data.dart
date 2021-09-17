import 'package:fin_calc/utilities/transaction_card.dart';
import 'package:flutter/material.dart';
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
    'Bill',
    'Self Transfer',
  ];

  List _transactionTypesList = [
    'Credit',
    'Debit',
  ];

  List<TransactionCard> _transactions = [];

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
