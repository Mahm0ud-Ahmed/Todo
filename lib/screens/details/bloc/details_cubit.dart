import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/models/todo_model.dart';
import 'package:todo_task/screens/details/bloc/details_state.dart';
import 'package:todo_task/shared/network/local/database/todo_db.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

class DetailsCubit extends Cubit<TodoAppState> {
  DetailsCubit() : super(InitialDetailsScreen());

  static DetailsCubit get(context) => BlocProvider.of(context);

  TodoDb _database = TodoDb();

  bool isChecked;

  initialCurrentStateCheckBox(int oldState) {
    if (oldState == 1) {
      isChecked = true;
    } else {
      isChecked = false;
    }
  }

  void changeStateCheckBox(bool newState) {
    isChecked = newState;
    emit(ChangeStateCheckBox());
  }

  updateItem(TodoModel model) {
    emit(LoadingUpdateState());
    _database.updateDb(model).then((value) {
      print('Successfully Update');
      emit(SuccessUpdateState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateState());
    });
  }

  int handleDataBeforeSetToDB() {
    const taskDone = 1;
    const taskActive = 0;
    if (isChecked) {
      return taskDone;
    } else {
      return taskActive;
    }
  }
}
