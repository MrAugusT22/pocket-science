import 'package:fin_calc/utilities/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends ChangeNotifier {
  late bool _isDarkMode;
  late Color kMyColor;
  late ThemePreferences _themePreferences;

  UserData() {
    _isDarkMode = true;
    kMyColor = Colors.blue;
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
  String monYr = '';

  bool cancel = true;

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
        borderSide: BorderSide(color: kMyColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
    );
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
    return [mon, date, monYr];
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

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    _themePreferences.setTheme(_isDarkMode);
    notifyListeners();
  }

  void getPreferences() async {
    _isDarkMode = await _themePreferences.getTheme();
    notifyListeners();
  }

  Color get getMyColor {
    return kMyColor;
  }

  void updateMyColor(Color color) {
    kMyColor = color;
    String value = color.value.toRadixString(16);
    _themePreferences.setAccentColor(value);
    notifyListeners();
  }

  void getAccentColor() async {
    String value = await _themePreferences.getAccentColor();
    int hexColor = int.parse(value, radix: 16);
    print(hexColor);
    kMyColor = Color(hexColor);
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

  setAccentColor(String color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('color', color);
    print('color set');
  }

  getAccentColor() async {
    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getString('color') ?? 'FF2196F3';
    return color;
  }
}
