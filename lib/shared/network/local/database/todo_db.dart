import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../models/todo_model.dart';
import 'constant_db.dart';

class TodoDb {
  Database _database;

  Future<Database> _openDb() async {
    return _database = await openDatabase(
      join(await getDatabasesPath(), ConstantDb.DATABASE_NAME),
      version: 1,
      onCreate: (Database db, int version) {
        db
            .execute('CREATE TABLE ${ConstantDb.TABLE_NAME} '
                '(${ConstantDb.COLUMN_ID} INTEGER PRIMARY KEY, '
                '${ConstantDb.COLUMN_TITLE} TEXT NOT NULL, '
                '${ConstantDb.COLUMN_DESCRIPTION} TEXT, '
                '${ConstantDb.COLUMN_TIME} TEXT NOT NULL, '
                '${ConstantDb.COLUMN_DATE} TEXT NOT NULL, '
                '${ConstantDb.COLUMN_STATUS} INTEGER)')
            .then((value) => print('Created Db'))
            .catchError((error) => print('Error Db ${error.toString()}'));
      },
    );
  }

  Future<int> insertDb(TodoModel todo) async {
    _database = await _openDb();

    int index = await _database.insert(ConstantDb.TABLE_NAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _database.close();
    print(index);
    return index;
  }

  Future<int> updateDb(TodoModel todo) async {
    _database = await _openDb();
    int index = await _database.update(ConstantDb.TABLE_NAME, todo.toMap(),
        where: '${ConstantDb.COLUMN_ID} = ?', whereArgs: [todo.id]);
    _database.close();
    return index;
  }

  Future<int> deleteDb(TodoModel todo) async {
    _database = await _openDb();

    int index = await _database.delete(ConstantDb.TABLE_NAME,
        where: '${ConstantDb.COLUMN_ID} = ?', whereArgs: [todo.id]);
    _database.close();
    return index;
  }

  Future<List<TodoModel>> queryDb() async {
    _database = await _openDb();

    List<Map<String, dynamic>> map =
        await _database.query(ConstantDb.TABLE_NAME);

    List<TodoModel> list = [];

    for (var model in map) {
      list.add(TodoModel.fromMab(model));
    }
    _database.close();
    return list;
  }
}
