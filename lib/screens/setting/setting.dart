import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/shared/network/local/database/todo_db.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TodoDb data = TodoDb();
  final List<TodoModel> taskData = [];

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  int randomColor(int rate) {
    Random random = Random();
    return random.nextInt(rate);
  }
}
