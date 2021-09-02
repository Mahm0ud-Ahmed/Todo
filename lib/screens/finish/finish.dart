import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/shared/component/components.dart';
import 'package:todo_task/shared/logic_bloc/todo_cubit.dart';
import 'package:todo_task/shared/logic_bloc/todo_state.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

class Finish extends StatefulWidget {
  @override
  _FinishState createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  TodoCubit _cubit;

  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(
      create: (context) => TodoCubit(),
      child: BlocConsumer<TodoCubit, TodoAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InitialViewTodoScreen) {
            _cubit = TodoCubit.get(context)..getAllDataFromDB();
          }
          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 32),
                decoration: BoxDecoration(
                  color: Color(0xfff0f4fd),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(54),
                    topRight: Radius.circular(54),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: _visible ? 1 : 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Color(0xff6c68d0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Finish Tasks',
                      style: TextStyle(
                        color: Colors.grey.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
              ),
              state is LoadingDataState
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.only(top: 66),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        child: ListView.builder(
                          itemCount: _cubit.finishTodo.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return customCard(
                              title: _cubit.finishTodo[index].title,
                              description: _cubit.finishTodo[index].description,
                              time: _cubit.finishTodo[index].time,
                              date: _cubit.finishTodo[index].date,
                              stateTask:
                                  _cubit.stateTodo[_cubit.finishTodo[index].id],
                              colorText: _cubit
                                  .colorStateTodo[_cubit.finishTodo[index].id],
                            );
                          },
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
