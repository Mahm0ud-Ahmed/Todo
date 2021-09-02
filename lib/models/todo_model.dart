import 'package:flutter/material.dart';
import 'package:todo_task/shared/network/local/database/constant_db.dart';

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
    id = map[ConstantDb.COLUMN_ID];
    title = map[ConstantDb.COLUMN_TITLE];
    description = map[ConstantDb.COLUMN_DESCRIPTION];
    time = map[ConstantDb.COLUMN_TIME];
    date = map[ConstantDb.COLUMN_DATE];
    isFinish = map[ConstantDb.COLUMN_STATUS] ?? 0;
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
