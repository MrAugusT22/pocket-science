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
    required String name,
    required String email,
    required String color,
    required bool isDarkMode,
  }) async {
    Provider.of<UserData>(context, listen: false)
        .updateMyColor(Color(int.parse(color, radix: 16)));
    Provider.of<UserData>(context, listen: false).toggleDarkMode(isDarkMode);

    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'color': color,
      'darkMode': isDarkMode,
    });
  }
}
