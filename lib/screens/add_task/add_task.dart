import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/screens/layout/bloc/nav_bar_cubit.dart';
import 'package:todo_task/shared/component/components.dart';
import 'package:todo_task/shared/network/local/database/todo_db.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  TodoDb todo = TodoDb();

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
      backgroundColor: Color(0xfff0f4fd),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      child: Column(
                        children: [
                          Text(
                            DateFormat('dd - MMM - y').format(DateTime.now()),
                            style: TextStyle(fontSize: 24, letterSpacing: 1.3),
                          ),
                          Text(
                            'Today',
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo.shade900,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    customTextField(
                      label: 'Title',
                      controller: _titleController,
                      textType: TextInputType.text,
                      prefixIcon: Icon(Icons.title),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'This field should not be empty!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    customTextField(
                      label: 'Description',
                      controller: _descriptionController,
                      textType: TextInputType.text,
                      prefixIcon: Icon(Icons.description),
                      lines: 3,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    customTextField(
                      label: 'Time',
                      controller: _timeController,
                      textType: TextInputType.datetime,
                      prefixIcon: Icon(Icons.more_time),
                      onTab: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) => _timeController.text =
                            value.format(context).toString());
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'This field should not be empty!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    customTextField(
                      label: 'Date',
                      controller: _dateController,
                      textType: TextInputType.datetime,
                      prefixIcon: Icon(Icons.date_range),
                      onTab: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            Duration(days: 30),
                          ),
                        ).then((value) => _dateController.text =
                            DateFormat('y-MM-dd').format(value));
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'This field should not be empty!';
                        }
                        return null;
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 35),
                      child: ElevatedButton(
                        child: Text(
                          'ADD TODO',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade100,
                            letterSpacing: 1,
                            wordSpacing: 4,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff6c68d0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            todo.insertDb(
                              TodoModel(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                time: _timeController.text,
                                date: _dateController.text,
                              ),
                            );
                            NavBarCubit.get(context).nextNavBarScreen(0);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
