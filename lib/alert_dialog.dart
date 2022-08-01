import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel }


class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(body),
            shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(10.0),
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.cancel),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),
                ),
              ),

              RaisedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.yes),
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),
                ),
              )


            ],
          );
        },);

   return(action != null) ? action:DialogsAction.cancel;
  }
}
