import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/bloc/business_logic/todo_state.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/presention/widget/components.dart';
import 'package:todo_task/presention/widget/todo_card.dart';

class DataActiveTask extends StatefulWidget {
  const DataActiveTask({Key key}) : super(key: key);

  @override
  State<DataActiveTask> createState() => _DataActiveTaskState();
}

class _DataActiveTaskState extends State<DataActiveTask> {
  List<TodoModel> _activeTodo = [];
  TodoCubit _cubit;
  TodoModel _currentTodo;
  TodoModel _selectedItem;

  @override
  void initState() {
    super.initState();
    _cubit = TodoCubit.get(context);
    _activeTodo = _cubit.activeTodo;
  }

  @override
  Widget build(BuildContext context) {
    int index;
    return Container(
      margin: const EdgeInsets.only(top: 66),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: index == _activeTodo.length
            ? _activeTodo.length + 1
            : _activeTodo.length,
        itemBuilder: (context, index) {
          index = index;
          _currentTodo = _activeTodo[index];
          return Column(
            children: [
              TodoCard(
                todo: _currentTodo,
                stateTask: _cubit.stateTodo[_currentTodo.id],
                colorText: _cubit.colorStateTodo[_currentTodo.id],
                onSubmitPopUpMenu: (String selected) {
                  _selectedItem = _activeTodo[index];
                  checkChooseEditOrDeleteBtn(selected);
                },
                onClick: () {
                  _selectedItem = _activeTodo[index];
                  Navigator.of(context).pushNamed(
                    detailsScreen,
                    arguments: _selectedItem,
                  );
                },
              ),
              if (index == _activeTodo.length - 1)
                const SizedBox(
                  height: 30,
                ),
            ],
          );
        },
      ),
    );
  }

  void checkChooseEditOrDeleteBtn(String chooseSelected) {
    switch (chooseSelected) {
      case 'Edit':
        Navigator.of(context).pushNamed(editScreen, arguments: _selectedItem);
        break;
      case 'Delete':
        customDialog(
          context: context,
          type: DialogType.QUESTION,
          description: 'Are you sure?',
          title: 'Delete!',
          okBtn: () {
            _cubit.deleteItemFromDB(_selectedItem);
            _cubit.getAllDataFromDB();
          },
        );
        break;
    }
  }
}
