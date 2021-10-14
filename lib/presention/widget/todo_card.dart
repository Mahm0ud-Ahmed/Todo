import 'package:flutter/material.dart';
import 'package:todo_task/config/style/colors.dart';
import 'package:todo_task/constant.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/presention/widget/body_card.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key key,
    this.todo,
    this.stateTask,
    this.onClick,
    this.colorText,
    this.onSubmitPopUpMenu,
  }) : super(key: key);
  final TodoModel todo;
  final String stateTask;
  final Color colorText;
  final Function(String) onSubmitPopUpMenu;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      // color: switchState ? cardDarkColor : cardLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: BodyCard(
          todo: todo,
          colorText: colorText,
          stateTask: stateTask,
          onClick: onClick,
          onSubmitPopUpMenu: onSubmitPopUpMenu,
        ),
      ),
    );
  }
}
