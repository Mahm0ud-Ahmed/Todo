import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/data/repository/todo_repository.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TodoRepository data = TodoRepository();
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
