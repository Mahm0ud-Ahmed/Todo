import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

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

Future<DateTime> datePicker(BuildContext context) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(
      const Duration(days: 30),
    ),
  );
}

Future<TimeOfDay> timePicker(BuildContext context) async {
  return await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
}
