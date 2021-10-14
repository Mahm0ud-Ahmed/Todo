import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/bloc/business_logic/todo_state.dart';
import 'package:todo_task/config/style/colors.dart';
import 'package:todo_task/constant.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/data/repository/todo_repository.dart';
import 'package:todo_task/presention/widget/page_title.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TodoRepository data = TodoRepository();
  final List<TodoModel> taskData = [];
  TodoCubit _cubit;

  @override
  void initState() {
    _cubit = TodoCubit.get(context);
    super.initState();
  }

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
          title: 'Settings',
        ),
        Container(
          margin: const EdgeInsets.only(top: 66),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: ListTile(
            title: const Text(
              'Dark Mode',
              style: TextStyle(fontSize: 20),
            ),
            trailing: BlocBuilder<TodoCubit, TodoAppState>(
              builder: (context, state) {
                return Switch(
                  activeColor: btnNavIconDarkColor,
                  value: switchState,
                  onChanged: (newState) async {
                    await _cubit.changeStyle(newState);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
