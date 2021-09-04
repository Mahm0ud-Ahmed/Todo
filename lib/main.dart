import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/screens/details/todo_details.dart';
import 'package:todo_task/screens/edit/edit.dart';
import 'package:todo_task/screens/layout/sign/sign.dart';
import 'package:todo_task/screens/sign_in/sign_in.dart';
import 'package:todo_task/screens/sign_up/sign_up.dart';
import 'package:todo_task/shared/network/local/observer.dart';
import 'package:todo_task/shared/style/style.dart';

import 'screens/layout/home_screen/home_screen.dart';

bool isLogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();

  User user = FirebaseAuth.instance.currentUser;
  user != null ? isLogin = true : isLogin = false;
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: isLogin ? HomeScreen.HOME_MAIN : Sign.SIGN,
      routes: {
        Sign.SIGN: (_) => Sign(),
        SignIn.SIGN_IN: (_) => SignIn(),
        SignUp.SIGN_UP: (_) => SignUp(),
        HomeScreen.HOME_MAIN: (_) => HomeScreen(),
        TodoDetails.TODO_DETAILS: (_) => TodoDetails(),
        EditScreen.EDIT_SCREEN: (_) => EditScreen(),
      },
    );
  }
}
