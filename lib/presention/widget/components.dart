import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

AwesomeDialog customDialog({
  @required BuildContext context,
  @required DialogType type,
  @required String title,
  @required String description,
  @required Function okBtn,
}) {
  return AwesomeDialog(
    context: context,
    dialogType: type,
    animType: AnimType.BOTTOMSLIDE,
    title: title,
    desc: description,
    btnCancelOnPress: () {},
    btnOkOnPress: okBtn,
  )..show();
}

void showToast(String msg, Color color) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
