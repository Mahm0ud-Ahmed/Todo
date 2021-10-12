import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/bloc/business_logic/todo_state.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/presention/widget/components.dart';
import 'package:todo_task/presention/widget/todo_card.dart';

class DataDoneTask extends StatefulWidget {
  const DataDoneTask({Key key}) : super(key: key);

  @override
  State<DataDoneTask> createState() => _DataDoneTaskState();
}

class _DataDoneTaskState extends State<DataDoneTask> {
  List<TodoModel> _doneTodo = [];
  TodoCubit _cubit;
  TodoModel _currentTodo;
  TodoModel _selectedItem;

  @override
  void initState() {
    super.initState();
    _cubit = TodoCubit.get(context);
    _doneTodo = _cubit.finishTodo;
  }

  @override
  Widget build(BuildContext context) {
    int index;
    return Container(
      margin: const EdgeInsets.only(top: 66),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount:
            index == _doneTodo.length ? _doneTodo.length + 1 : _doneTodo.length,
        itemBuilder: (context, index) {
          index = index;
          _currentTodo = _doneTodo[index];
          return Column(
            children: [
              TodoCard(
                todo: _currentTodo,
                stateTask: _cubit.stateTodo[_currentTodo.id],
                colorText: _cubit.colorStateTodo[_currentTodo.id],
                onSubmitPopUpMenu: (String selected) {
                  _selectedItem = _doneTodo[index];
                  checkChooseEditOrDeleteBtn(selected);
                },
                onClick: () {
                  _selectedItem = _doneTodo[index];
                  Navigator.of(context).pushNamed(
                    detailsScreen,
                    arguments: _selectedItem,
                  );
                },
              ),
              if (index == _doneTodo.length - 1)
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
