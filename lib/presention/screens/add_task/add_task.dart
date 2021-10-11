import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/data/repository/todo_repository.dart';
import 'package:todo_task/presention/widget/building_fields.dart';
import 'package:todo_task/presention/widget/custom_button.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  TodoRepository todo = TodoRepository();

  @override
  void dispose() {
    super.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f4fd),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('dd - MMM - y').format(DateTime.now()),
                        style:
                            const TextStyle(fontSize: 24, letterSpacing: 1.3),
                      ),
                      Text(
                        'Today',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade900,
                            ),
                      ),
                    ],
                  ),
                ),
                BuildingFields(
                  formKey: _formKey,
                  titleController: _titleController,
                  timeController: _timeController,
                  descriptionController: _descriptionController,
                  dateController: _dateController,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 35),
                  child: CustomButton(
                    title: 'ADD TODO',
                    color: Colors.deepPurpleAccent.shade200,
                    onClick: () async {
                      if (_formKey.currentState.validate()) {
                        final isAdd = await insertTodo();
                        if (isAdd) {
                          Navigator.pushReplacementNamed(context, bottomNav);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> insertTodo() async {
    final TodoModel todo = TodoModel(
      title: _titleController.text,
      description: _descriptionController.text,
      time: _timeController.text,
      date: _dateController.text,
    );
    return await TodoCubit.get(context).insertItem(todo);
  }
}
