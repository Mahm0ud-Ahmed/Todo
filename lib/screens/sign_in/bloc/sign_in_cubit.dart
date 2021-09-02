import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/screens/sign_in/bloc/sign_in_state.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

class SignInCubit extends Cubit<TodoAppState> {
  SignInCubit() : super(InitialSignIn());

  static SignInCubit get(context) => BlocProvider.of<SignInCubit>(context);

  bool visibility = true;

  void changeVisibility() {
    visibility = !visibility;
    emit(ChangeVisibilityState());
  }
}
