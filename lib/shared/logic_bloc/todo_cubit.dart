import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/shared/logic_bloc/todo_state.dart';
import 'package:todo_task/shared/network/local/database/todo_db.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

enum TodoState { ACTIVE, DONE, FINISH }

class TodoCubit extends Cubit<TodoAppState> {
  TodoCubit() : super(InitialViewTodoScreen());

  static TodoCubit get(context) => BlocProvider.of(context);

  TodoDb _database = TodoDb();
  List<TodoModel> activeTodo = [];
  List<TodoModel> finishTodo = [];
  List<TodoModel> todo = [];

  Map<int, String> stateTodo = {};
  Map<int, Color> colorStateTodo = {};

  getAllDataFromDB() {
    emit(LoadingDataState());
    _database.queryDb().then((value) {
      todo.addAll(value);
      // print(todo);
      addDataInTaskAndFinish();
      todo.forEach((element) {
        stateTodo.addAll(
          {
            element.id: splitText(element.date, element.isFinish),
          },
        );
        colorStateTodo.addAll(
          {
            element.id: setColorToText(stateTodo[element.id]),
          },
        );
      });
      emit(SuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDataState());
    });
  }

  void addDataInTaskAndFinish() {
    const int taskNotDone = 0;
    todo.where((todo) {
      if (todo.isFinish == taskNotDone) {
        addActiveDataAndFinished(todo);
        return true;
      } else {
        finishTodo.add(todo);
        finishTodo.reversed.toList();
        return true;
      }
    }).toList();
  }

  addActiveDataAndFinished(TodoModel model) {
    bool isFinish =
        compareToDate(model.date) == TodoState.FINISH ? true : false;
    if (isFinish) {
      finishTodo.add(model);
    } else {
      activeTodo.add(model);
    }
    finishTodo.reversed.toList();
    activeTodo.reversed.toList();
  }

  TodoState compareToDate(String firstData, [int isDone]) {
    const finishTaskEqual = 1;
    if (isDone == finishTaskEqual) {
      return TodoState.DONE;
    }
    String nowDate = DateFormat('y-MM-dd').format(DateTime.now());
    DateTime currentDate = DateTime.parse(firstData);
    DateTime currentDateNow = DateTime.parse(nowDate);
    if (currentDate.isAfter(currentDateNow)) {
      return TodoState.ACTIVE;
    } else if (currentDate.isBefore(currentDateNow)) {
      return TodoState.FINISH;
    } else {
      return TodoState.ACTIVE;
    }
  }

  String splitText(String firstData, [int isDone]) {
    TodoState value = compareToDate(firstData, isDone);
    return value.toString().split('.').last;
  }

  Color setColorToText(String state) {
    var color;
    switch (state) {
      case 'DONE':
        color = Colors.amber;
        break;
      case 'ACTIVE':
        color = Colors.green;
        break;
      case 'FINISH':
        color = Colors.red;
        break;
    }
    return color;
  }
}
