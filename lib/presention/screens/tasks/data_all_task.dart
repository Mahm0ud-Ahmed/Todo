import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/bloc/business_logic/todo_state.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/presention/widget/components.dart';
import 'package:todo_task/presention/widget/todo_card.dart';

class DataAllTask extends StatefulWidget {
  const DataAllTask({Key key}) : super(key: key);

  @override
  State<DataAllTask> createState() => _DataAllTaskState();
}

class _DataAllTaskState extends State<DataAllTask> {
  List<TodoModel> _allTodo = [];
  TodoCubit _cubit;
  TodoModel _currentTodo;
  TodoModel _selectedItem;

  @override
  void initState() {
    super.initState();
    _cubit = TodoCubit.get(context)..getAllDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    int index;
    return Container(
      margin: const EdgeInsets.only(top: 66),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: BlocBuilder<TodoCubit, TodoAppState>(
        builder: (context, state) {
          if (state is SuccessDataState) {
            _allTodo = state.allTodo;
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: index == _allTodo.length
                ? _allTodo.length + 1
                : _allTodo.length,
            itemBuilder: (context, index) {
              index = index;
              _currentTodo = _allTodo[index];
              return Column(
                children: [
                  TodoCard(
                    todo: _currentTodo,
                    stateTask: _cubit.stateTodo[_currentTodo.id],
                    colorText: _cubit.colorStateTodo[_currentTodo.id],
                    onSubmitPopUpMenu: (String selected) {
                      _selectedItem = _allTodo[index];
                      checkChooseEditOrDeleteBtn(selected);
                    },
                    onClick: () {
                      _selectedItem = _allTodo[index];
                      Navigator.of(context).pushNamed(
                        detailsScreen,
                        arguments: _selectedItem,
                      );
                    },
                  ),
                  if (index == _allTodo.length - 1)
                    const SizedBox(
                      height: 30,
                    ),
                ],
              );
            },
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
