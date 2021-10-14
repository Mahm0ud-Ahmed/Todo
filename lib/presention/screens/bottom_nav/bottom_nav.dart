import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/bloc/business_logic/todo_state.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/config/style/colors.dart';
import 'package:todo_task/data/datasources/local/storage_pref.dart';
import 'package:todo_task/presention/screens/active/active.dart';
import 'package:todo_task/presention/screens/add_task/add_task.dart';
import 'package:todo_task/presention/screens/finish/finish.dart';
import 'package:todo_task/presention/screens/setting/setting.dart';
import 'package:todo_task/presention/screens/tasks/tasks.dart';

import '../../../constant.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();

  const BottomNav();
}

class _BottomNavState extends State<BottomNav> {
  int _pageIndex = 0;

  List<Widget> bottomScreen = <Widget>[
    Tasks(),
    Active(),
    AddTask(),
    Finish(),
    Setting(),
  ];

  // Color(0xff5a55ca)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed(signIn);
            },
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: _pageIndex,
        style: TabStyle.fixedCircle,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        activeColor: Colors.white,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: const [
          TabItem(
            icon: Icons.all_inbox,
          ),
          TabItem(
            icon: Icons.work,
          ),
          TabItem(
            icon: Icons.add,
          ),
          TabItem(
            icon: Icons.done,
          ),
          TabItem(
            icon: Icons.settings,
          ),
        ],
      ),
      body: bottomScreen[_pageIndex],
    );
  }
}
