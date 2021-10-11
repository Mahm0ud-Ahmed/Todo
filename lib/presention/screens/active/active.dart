import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/presention/screens/active/data_active_task.dart';
import 'package:todo_task/presention/widget/page_title.dart';

class Active extends StatefulWidget {
  @override
  _ActiveState createState() => _ActiveState();
}

class _ActiveState extends State<Active> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 32),
          decoration: const BoxDecoration(
            color: Color(0xfff0f4fd),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(54),
              topRight: Radius.circular(54),
            ),
          ),
        ),
        const PageTitle(
          title: 'Active Tasks',
        ),
        const DataActiveTask(),
      ],
    );
  }
}
