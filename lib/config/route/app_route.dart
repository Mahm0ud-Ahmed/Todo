import 'package:flutter/material.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/presention/screens/bottom_nav/bottom_nav.dart';
import 'package:todo_task/presention/screens/details/todo_details.dart';
import 'package:todo_task/presention/screens/edit/edit.dart';
import 'package:todo_task/presention/screens/sign/sign.dart';
import 'package:todo_task/presention/screens/sign/sign_in/sign_in.dart';
import 'package:todo_task/presention/screens/sign/sign_up/sign_up.dart';

class AppRoute {
  Route generateRoute(RouteSettings route) {
    switch (route.name) {
      case sign:
        return MaterialPageRoute(builder: (_) => const Sign());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case bottomNav:
        return MaterialPageRoute(builder: (_) => const BottomNav());
      case editScreen:
        return MaterialPageRoute(
          builder: (_) => EditScreen(todo: route.arguments as TodoModel),
        );
      case detailsScreen:
        return MaterialPageRoute(
          builder: (_) => TodoDetails(todo: route.arguments as TodoModel),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Sign());
    }
  }
}
