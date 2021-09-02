import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:todo_task/screens/layout/bloc/nav_bar_cubit.dart';
import 'package:todo_task/screens/sign_in/sign_in.dart';
import 'package:todo_task/shared/network/local/database/todo_db.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

class HomeScreen extends StatefulWidget {
  static const String HOME_MAIN = 'homeMain';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoDb db;

  NavBarCubit _cubit;

  @override
  void initState() {
    super.initState();
    db = TodoDb();
  }

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<HomeScreenProvider>(context);
    return BlocProvider<NavBarCubit>(
      create: (context) => NavBarCubit(),
      child: BlocConsumer<NavBarCubit, TodoAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          _cubit = NavBarCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xff5a55ca),
            appBar: AppBar(
              title: Text('ToDo App'),
              elevation: 0,
              backgroundColor: Color(0xff5a55ca),
              actions: [
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushReplacementNamed(SignIn.SIGN_IN);
                    })
              ],
            ),
            bottomNavigationBar: ConvexAppBar(
              initialActiveIndex: _cubit.pageIndex,
              style: TabStyle.fixedCircle,
              backgroundColor: Color(0xff5a55ca),
              activeColor: Colors.white,
              onTap: (index) {
                _cubit.nextNavBarScreen(index);
              },
              items: [
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
            body: _cubit.bottomScreen[_cubit.pageIndex],
          );
        },
      ),
    );
  }
}
