import 'package:sqflite/sqflite.dart';
import 'package:todo_task/data/datasources/local/constant_db.dart';
import 'package:todo_task/data/datasources/local/todo_db.dart';
import 'package:todo_task/data/model/todo_model.dart';

class TodoRepository {
  Database _database;

  Future<List<TodoModel>> queryDb() async {
    _database = await TodoDb.singleton();
    final List<Map<String, dynamic>> map =
        await _database.query(ConstantDb.TABLE_NAME);

    final List<TodoModel> list = [];

    for (final model in map) {
      list.add(TodoModel.fromMab(model));
    }
    // _database.close();
    return list;
  }

  Future<int> insertDb(TodoModel todo) async {
    _database = await TodoDb.singleton();

    final int index = await _database.insert(
        ConstantDb.TABLE_NAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    // _database.close();
    return index;
  }

  Future<int> updateDb(TodoModel todo) async {
    _database = await TodoDb.singleton();
    final int index = await _database.update(
        ConstantDb.TABLE_NAME, todo.toMap(),
        where: '${ConstantDb.COLUMN_ID} = ?', whereArgs: [todo.id]);
    // _database.close();
    return index;
  }

  Future<int> deleteDb(TodoModel todo) async {
    _database = await TodoDb.singleton();

    final int index = await _database.delete(ConstantDb.TABLE_NAME,
        where: '${ConstantDb.COLUMN_ID} = ?', whereArgs: [todo.id]);
    // _database.close();
    return index;
  }
}
