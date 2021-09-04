import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/screens/details/bloc/details_cubit.dart';
import 'package:todo_task/screens/details/bloc/details_state.dart';
import 'package:todo_task/screens/layout/bloc/nav_bar_cubit.dart';
import 'package:todo_task/screens/layout/home_screen/home_screen.dart';
import 'package:todo_task/shared/component/components.dart';
import 'package:todo_task/shared/logic_bloc/todo_state.dart';
import 'package:todo_task/shared/network/local/database/todo_db.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

class EditScreen extends StatefulWidget {
  static const String EDIT_SCREEN = 'edit_Screen';

  @override
  _EditScreenState createState() => _EditScreenState();
}

TodoDb _db;

class _EditScreenState extends State<EditScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  TodoModel _todo;
  DetailsCubit _cubit;
  int _id;
  int _isFinish;

  @override
  void didChangeDependencies() {
    _db = TodoDb();
    _todo = ModalRoute.of(context).settings.arguments;
    _titleController.text = _todo.title;
    _descriptionController.text = _todo.description;
    _timeController.text = _todo.time;
    _dateController.text = _todo.date;
    _id = _todo.id;
    _isFinish = _todo.isFinish;
    super.didChangeDependencies();
  }

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
    return BlocProvider<DetailsCubit>(
      create: (context) => DetailsCubit(),
      child: Scaffold(
        backgroundColor: Color(0xfff0f4fd),
        appBar: AppBar(
          title: Text('Edit To Do'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Center(
                child: BlocConsumer<DetailsCubit, TodoAppState>(
                  listener: (context, state) {
                    if (state is SuccessUpdateState) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.HOME_MAIN, (route) => false);
                    }
                  },
                  builder: (context, state) {
                    if (state is InitialDetailsScreen) {
                      if (_cubit == null) _cubit = DetailsCubit.get(context);
                    }
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 12),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('dd - MMM - y')
                                    .format(DateTime.now()),
                                style:
                                    TextStyle(fontSize: 24, letterSpacing: 1.3),
                              ),
                              Text(
                                'Today',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
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
                              'Update Todo',
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
                                _todo = TodoModel(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  time: _timeController.text,
                                  date: _dateController.text,
                                  id: _id,
                                  isFinish: _isFinish,
                                );
                                _cubit.updateItem(_todo);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
