import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/shared/component/components.dart';
import 'package:todo_task/shared/logic_bloc/todo_cubit.dart';
import 'package:todo_task/shared/logic_bloc/todo_state.dart';
import 'package:todo_task/shared/network/local/database/todo_db.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final TodoDb data = TodoDb();
  final List<TodoModel> taskData = [];

  bool _visible = false;

  TodoCubit _cubit;
  List<TodoModel> todo = [];

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
            todo = _cubit.todo.reversed.toList();
          }
        },
        builder: (context, state) {
          if (state is InitialViewTodoScreen) {
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
                      'All Tasks',
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
                            return customCard(
                              title: todo[index].title,
                              description: todo[index].description,
                              time: todo[index].time,
                              date: todo[index].date,
                              stateTask: _cubit.stateTodo[todo[index].id],
                              colorText: _cubit.colorStateTodo[todo[index].id],
                            );
                          },
                          itemCount: todo.length,
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
