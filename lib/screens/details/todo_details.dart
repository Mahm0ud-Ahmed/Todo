import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/screens/details/bloc/details_cubit.dart';
import 'package:todo_task/screens/layout/home_screen/home_screen.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

import 'bloc/details_state.dart';

class TodoDetails extends StatefulWidget {
  static const String TODO_DETAILS = 'todoDetails';

  @override
  _TodoDetailsState createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  TodoModel _todo;
  DetailsCubit _cubit;

  @override
  void didChangeDependencies() {
    _todo = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsCubit>(
      create: (context) => DetailsCubit(),
      child: BlocConsumer<DetailsCubit, TodoAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InitialDetailsScreen) {
            _cubit = DetailsCubit.get(context);
            _cubit.initialCurrentStateCheckBox(_todo.isFinish);
          }
          return Scaffold(
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailsItem(context, _todo.title, 'Title: '),
                    _buildDetailsItem(
                        context, _todo.description, 'Description: '),
                    _buildDetailsItem(context, _todo.date, 'Date: '),
                    _buildDetailsItem(context, _todo.time, 'Time: '),
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
            floatingActionButton: state is ChangeStateCheckBox
                ? FloatingActionButton(
                    child: Icon(Icons.done),
                    onPressed: () {
                      _todo.isFinish = _cubit.handleDataBeforeSetToDB();
                      _cubit.updateItem(_todo);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.HOME_MAIN, (route) => false);
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
