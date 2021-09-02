import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/screens/details/bloc/details_state.dart';
import 'package:todo_task/shared/network/local/database/todo_db.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

class DetailsCubit extends Cubit<TodoAppState> {
  DetailsCubit() : super(InitialDetailsScreen());

  static DetailsCubit get(context) => BlocProvider.of(context);

  TodoDb _database = TodoDb();

  bool isChecked = false;

  void changeStateCheckBox(bool newState) {
    isChecked = newState;
    emit(ChangeStateCheckBox());
  }

  updateItem(TodoModel model) {
    emit(LoadingUpdateState());
    _database.updateDb(model).then((value) {
      print('Success');
      emit(SuccessUpdateState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateState());
    });
  }
}
