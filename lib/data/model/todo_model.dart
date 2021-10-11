import 'package:flutter/material.dart';
import 'package:todo_task/data/datasources/local/constant_db.dart';

class TodoModel {
  int id;
  String title;
  String description;
  String time;
  String date;
  int isFinish;

  TodoModel({
    this.id,
    @required this.title,
    @required this.description,
    @required this.time,
    @required this.date,
    this.isFinish,
  });

  TodoModel.fromMab(Map<String, dynamic> map) {
    id = map[ConstantDb.COLUMN_ID] as int;
    title = map[ConstantDb.COLUMN_TITLE] as String;
    description = map[ConstantDb.COLUMN_DESCRIPTION] as String;
    time = map[ConstantDb.COLUMN_TIME] as String;
    date = map[ConstantDb.COLUMN_DATE] as String;
    isFinish = map[ConstantDb.COLUMN_STATUS] as int ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      ConstantDb.COLUMN_ID: this.id,
      ConstantDb.COLUMN_TITLE: this.title,
      ConstantDb.COLUMN_DESCRIPTION: this.description,
      ConstantDb.COLUMN_TIME: this.time,
      ConstantDb.COLUMN_DATE: this.date,
      ConstantDb.COLUMN_STATUS: this.isFinish,
    };
  }
}
