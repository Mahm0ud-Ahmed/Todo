import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constant_db.dart';

class TodoDb {
  static Database _database;

  TodoDb._();

  static Future<Database> _openDb() async {
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

  static Future<Database> singleton() async {
    if (_database != null) {
      return _database;
    } else {
      return _database = await _openDb();
    }
  }
}
