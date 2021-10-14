import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todo_task/config/style/colors.dart';
import 'package:todo_task/presention/screens/active/data_active_task.dart';
import 'package:todo_task/presention/widget/page_title.dart';

import '../../../constant.dart';

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
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
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
