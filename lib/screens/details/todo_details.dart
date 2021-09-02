import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/screens/details/bloc/details_cubit.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

import 'bloc/details_state.dart';

class TodoDetails extends StatelessWidget {
  static const String TODO_DETAILS = 'todoDetails';
  final TodoModel todo;

  TodoDetails({this.todo});

  DetailsCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsCubit>(
      create: (context) => DetailsCubit(),
      child: BlocConsumer<DetailsCubit, TodoAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InitialDetailsScreen) {
            _cubit = DetailsCubit.get(context);
          }
          return Scaffold(
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailsItem(context, todo.title, 'Title: '),
                    _buildDetailsItem(
                        context, todo.description, 'Description: '),
                    _buildDetailsItem(context, todo.date, 'Date: '),
                    _buildDetailsItem(context, todo.time, 'Time: '),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Task Done: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Checkbox(
                          value: _cubit.isChecked,
                          onChanged: (newState) =>
                              _cubit.changeStateCheckBox(newState),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: _cubit.isChecked
                ? FloatingActionButton(
                    child: Icon(Icons.done),
                    onPressed: () {
                      todo.isFinish = 1;
                      _cubit.updateItem(todo);
                      Navigator.pop(context);
                    },
                  )
                : Container(),
          );
        },
      ),
    );
  }

  Widget _buildDetailsItem(BuildContext context, String text, String title) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 2,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
