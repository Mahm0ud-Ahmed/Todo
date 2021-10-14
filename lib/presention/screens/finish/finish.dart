import 'package:flutter/material.dart';
import 'package:todo_task/config/style/colors.dart';
import 'package:todo_task/presention/screens/finish/data_done_task.dart';
import 'package:todo_task/presention/widget/page_title.dart';

import '../../../constant.dart';

class Finish extends StatefulWidget {
  @override
  _FinishState createState() => _FinishState();
}

class _FinishState extends State<Finish> {
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
          title: 'Done Tasks',
        ),
        const DataDoneTask(),
      ],
    );
  }
}
