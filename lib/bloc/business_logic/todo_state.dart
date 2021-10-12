import 'package:todo_task/data/model/todo_model.dart';

abstract class TodoAppState {}

class InitialViewTodoScreen extends TodoAppState {}

class SuccessDataState extends TodoAppState {
  final List<TodoModel> allTodo;
  final List<TodoModel> activeTodo;
  final List<TodoModel> finishTodo;
  SuccessDataState(this.allTodo, this.activeTodo, this.finishTodo);
}

class ErrorDataState extends TodoAppState {}

class SuccessInsertState extends TodoAppState {
  final String message;
  SuccessInsertState({this.message});
}

class ErrorInsertState extends TodoAppState {
  final String message;
  ErrorInsertState({this.message});
}

class SuccessUpdateState extends TodoAppState {
  final String message;
  SuccessUpdateState({this.message});
}

class ErrorUpdateState extends TodoAppState {
  final String message;
  ErrorUpdateState({this.message});
}

class SuccessDeleteData extends TodoAppState {
  final String message;
  SuccessDeleteData({this.message});
}

class ErrorDeleteData extends TodoAppState {
  final String message;
  ErrorDeleteData({this.message});
}
