import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'bloc/observer.dart';
import 'config/route/app_route.dart';
import 'config/style/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();

  final User user = FirebaseAuth.instance.currentUser;
  final String _initialRoute = user != null ? bottomNav : sign;

  runApp(
    TodoApp(
      initialRoute: _initialRoute,
      route: AppRoute(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  final AppRoute route;
  final String initialRoute;

  const TodoApp({@required this.route, @required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(
      create: (context) => TodoCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        onGenerateRoute: route.generateRoute,
        initialRoute: initialRoute,
      ),
    );
  }
}
