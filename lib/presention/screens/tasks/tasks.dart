import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todo_task/config/style/colors.dart';
import 'package:todo_task/constant.dart';
import 'package:todo_task/presention/screens/tasks/data_all_task.dart';
import 'package:todo_task/presention/widget/page_title.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 32),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(54),
              topRight: Radius.circular(54),
            ),
          ),
        ),
        const PageTitle(
          title: 'All Tasks',
        ),
        const DataAllTask(),
      ],
    );
  }
}
