import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/screens/details/todo_details.dart';
import 'package:todo_task/screens/edit/edit.dart';
import 'package:todo_task/shared/component/components.dart';
import 'package:todo_task/shared/logic_bloc/todo_cubit.dart';
import 'package:todo_task/shared/logic_bloc/todo_state.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

class Finish extends StatefulWidget {
  @override
  _FinishState createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  TodoCubit _cubit;
  List<TodoModel> _finishTodo = [];
  TodoModel _currentTodo;
  TodoModel _selectedItem;

  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(
      create: (context) => TodoCubit(),
      child: BlocConsumer<TodoCubit, TodoAppState>(
        listener: (context, state) {
          if (state is SuccessDataState) {
            _finishTodo = _cubit.finishTodo;
          }
          if (state is ChooseEditState) {
            Navigator.of(context)
                .pushNamed(EditScreen.EDIT_SCREEN, arguments: _selectedItem);
          }
          if (state is ChooseDeleteState) {
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
          }
        },
        builder: (context, state) {
          if (state is InitialViewTodoScreen) {
            if (_cubit == null)
              _cubit = TodoCubit.get(context)..getAllDataFromDB();
          }
          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 32),
                decoration: BoxDecoration(
                  color: Color(0xfff0f4fd),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(54),
                    topRight: Radius.circular(54),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _visible ? 1 : 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Color(0xff6c68d0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Active Tasks',
                      style: TextStyle(
                        color: Colors.grey.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
              ),
              state is LoadingDataState
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.only(top: 66),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            _currentTodo = _finishTodo[index];
                            return customCard(
                              title: _currentTodo.title,
                              description: _currentTodo.description,
                              time: _currentTodo.time,
                              date: _currentTodo.date,
                              stateTask: _cubit.stateTodo[_currentTodo.id],
                              colorText: _cubit.colorStateTodo[_currentTodo.id],
                              onSubmitPopUpMenu: (String selected) {
                                _cubit.sendStateNotification(selected);
                                _selectedItem = _finishTodo[index];
                              },
                              onClick: () {
                                _selectedItem = _finishTodo[index];
                                Navigator.of(context).pushNamed(
                                    TodoDetails.TODO_DETAILS,
                                    arguments: _selectedItem);
                              },
                            );
                          },
                          itemCount: _finishTodo.length,
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
