import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/constant.dart';
import 'package:todo_task/data/datasources/local/storage_pref.dart';
import 'bloc/business_logic/todo_cubit.dart';
import 'bloc/business_logic/todo_state.dart';
import 'bloc/observer.dart';
import 'config/route/app_route.dart';
import 'config/style/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await StoragePref.getInstance();
  switchState = await StoragePref.getValue('isDark') as bool ?? false;

  await Firebase.initializeApp();
  final User user = FirebaseAuth.instance.currentUser;
  final String _initialRoute = user != null ? bottomNav : sign;

  runApp(
    TodoApp(
      initialRoute: _initialRoute,
      route: AppRoute(),
      darkMode: switchState,
    ),
  );
}

class TodoApp extends StatelessWidget {
  final AppRoute route;
  final String initialRoute;
  final bool darkMode;

  const TodoApp(
      {@required this.route, @required this.initialRoute, this.darkMode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(
      create: (context) => TodoCubit(),
      child: BlocBuilder<TodoCubit, TodoAppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: switchState ? dark : light,
            themeMode: switchState ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: route.generateRoute,
            initialRoute: initialRoute,
          );
        },
      ),
    );
  }
}
