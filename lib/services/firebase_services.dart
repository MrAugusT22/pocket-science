import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FirebaseService {
  final uid;
  final context;
  FirebaseService({
    @required this.uid,
    @required this.context,
  });

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  Future updateUserData({
    required String color,
    required bool isDarkMode,
  }) async {
    Provider.of<UserData>(context, listen: false)
        .updateMyColor(Color(int.parse(color, radix: 16)));
    Provider.of<UserData>(context, listen: false).toggleDarkMode(isDarkMode);

    return await usersCollection.doc(uid).set({
      'color': color,
      'darkMode': isDarkMode,
    });
  }

  Future addTransactionData({
    required double amt,
    required String title,
    required bool debit,
    required String purchaseType,
    required DateTime date,
  }) async {
    String uid = Provider.of<UserData>(context, listen: false).getUserData[3];
    formatDate(date);

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('transactions')
        .add({
      'userId': uid,
      'amt': amt,
      'title': title,
      'debit': debit,
      'purchaseType': purchaseType,
      'date': date,
    });
  }
}
