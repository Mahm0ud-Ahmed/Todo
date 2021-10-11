import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/presention/widget/building_fields.dart';
import 'package:todo_task/presention/widget/custom_button.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
  final TodoModel todo;

  const EditScreen({this.todo});
}

class _EditScreenState extends State<EditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description;
    _timeController.text = widget.todo.time;
    _dateController.text = widget.todo.date;
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
    return Scaffold(
      backgroundColor: const Color(0xfff0f4fd),
      appBar: AppBar(
        title: const Text('Edit ToDo'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('dd - MMM - y').format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 24,
                          letterSpacing: 1.3,
                        ),
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
                  dateController: _dateController,
                  descriptionController: _descriptionController,
                  timeController: _timeController,
                  titleController: _titleController,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 35),
                  child: CustomButton(
                    title: 'Update Todo',
                    color: Colors.deepPurpleAccent.shade200,
                    onClick: () async {
                      if (_formKey.currentState.validate()) {
                        final isUpdate = await updateCurrentTodo();
                        if (isUpdate) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            bottomNav,
                            (route) => false,
                          );
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

  Future<bool> updateCurrentTodo() async {
    final TodoModel todo = TodoModel(
      title: _titleController.text,
      description: _descriptionController.text,
      time: _timeController.text,
      date: _dateController.text,
      id: widget.todo.id,
      isFinish: widget.todo.isFinish,
    );
    return await TodoCubit.get(context).updateItem(todo);
  }
}
