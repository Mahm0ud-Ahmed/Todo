import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/screens/active/active.dart';
import 'package:todo_task/screens/add_task/add_task.dart';
import 'package:todo_task/screens/finish/finish.dart';
import 'package:todo_task/screens/layout/bloc/nav_bar_state.dart';
import 'package:todo_task/screens/setting/setting.dart';
import 'package:todo_task/screens/tasks/tasks.dart';
import 'package:todo_task/shared/logic_bloc/todo_state.dart';
import 'package:todo_task/shared/network/local/database/todo_db.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';


class NavBarCubit extends Cubit<TodoAppState> {
  NavBarCubit() : super(InitialNavBar());

  static NavBarCubit get(context) => BlocProvider.of<NavBarCubit>(context);

  int pageIndex = 0;

  List<Widget> bottomScreen = <Widget>[
    Tasks(),
    Active(),
    AddTask(),
    Finish(),
    Setting(),
  ];

  void nextNavBarScreen(int index) {
    pageIndex = index;
    emit(ChangeNavBarScreenState());
  }

  TodoDb _database;
  List<TodoModel> todo;

  getAllDataFromDB() {
    emit(LoadingDataState());
    _database.queryDb().then((value) {
      print(value);
      emit(SuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDataState());
    });
  }
}
