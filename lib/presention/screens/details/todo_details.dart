import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/bloc/business_logic/todo_state.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/presention/widget/components.dart';

class TodoDetails extends StatefulWidget {
  final TodoModel todo;

  const TodoDetails({this.todo});

  @override
  _TodoDetailsState createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  bool _isCheck;

  @override
  void initState() {
    _isCheck = initialCheckBox(widget.todo.isFinish);
    super.initState();
  }

  bool initialCheckBox(int state) {
    if (state == 1) {
      return _isCheck = true;
    }
    return _isCheck = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailsItem(context, widget.todo.title, 'Title: '),
              _buildDetailsItem(
                context,
                widget.todo.description,
                'Description: ',
              ),
              _buildDetailsItem(context, widget.todo.date, 'Date: '),
              _buildDetailsItem(context, widget.todo.time, 'Time: '),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Task Done: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Checkbox(
                    value: _isCheck,
                    onChanged: (newState) {
                      setState(() {
                        _isCheck = newState;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocListener<TodoCubit, TodoAppState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is SuccessUpdateState) {
            showToast(state.message, Colors.green);
          }
          if (state is ErrorUpdateState) {
            showToast(state.message, Colors.red);
          }
        },
        child: FloatingActionButton(
          child: const Icon(Icons.done),
          onPressed: () {
            widget.todo.isFinish = handleDataBeforeSetToDB();
            TodoCubit.get(context).updateItem(widget.todo);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(bottomNav, (route) => false);
          },
        ),
      ),
    );
  }

  int handleDataBeforeSetToDB() {
    const taskDone = 1;
    const taskActive = 0;
    if (_isCheck) {
      return taskDone;
    }
    return taskActive;
  }

  Widget _buildDetailsItem(BuildContext context, String text, String title) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
