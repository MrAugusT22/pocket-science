import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowDialogBox {
  final context;
  final title;
  final msg;
  final actionButtonText;
  final delete;
  final index;
  final onPressed;

  ShowDialogBox({
    @required this.context,
    @required this.actionButtonText,
    @required this.msg,
    @required this.title,
    @required this.delete,
    this.index = 0,
    @required this.onPressed,
  });

  Future showDialogBox() async {
    bool _isDarkMode =
        Provider.of<UserData>(context, listen: false).getDarkMode;
    Color kMyColor =
        Provider.of<UserData>(context, listen: false).getMyColor;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor,
          title: Text(
            '/$title',
            style: TextStyle(
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          content: Text(
            msg,
            style: TextStyle(
              fontFamily: 'RobotoMono',
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: <Widget>[
            //Add
            TextButton(
              onPressed: onPressed,
              child: InvestmentCardText(
                  text: '$actionButtonText', color: kMyColor),
            ),
            //Cancel
            TextButton(
              onPressed: () {
                Provider.of<UserData>(context, listen: false)
                    .updateCancel(true);
                Navigator.of(context).pop();
              },
              child: InvestmentCardText(text: 'Cancel', color: Colors.blue),
            ),
          ],
        );
      },
    );
  }
}
