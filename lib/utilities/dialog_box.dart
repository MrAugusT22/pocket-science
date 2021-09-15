import 'package:flutter/material.dart';
import 'package:fin_calc/screens/home.dart';

class ShowDialogBox {
  final BuildContext context;
  final String title;
  final String msg;
  final String actionButtonText;
  final bool exit;

  ShowDialogBox(
      {required this.context,
        required this.actionButtonText,
        required this.msg,
        required this.title,
        required this.exit});

  void exitToWelcomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, HomePage.id, (route) => false);
  }

  Future showDialogBox() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.grey[900],
          title: Text(
            '/$title',
            style: TextStyle(
              color: Colors.white,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          content: Text(
            msg,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoMono',
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => exit
                  ? exitToWelcomePage(context)
                  : Navigator.of(context).pop(true),
              child: Text(
                actionButtonText,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }
}
