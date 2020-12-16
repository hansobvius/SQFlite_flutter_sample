import 'dart:async';
import 'dart:io';
import 'package:flutter_sqflite_example/app/database/BaseDatabase.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'dart:io';
import '../../DBContract.dart';


class UserDatabaseHelper extends BaseDatabase implements BaseContract{

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  static Database _database;

  final table = 'my_table';
  final columnId = '_id';
  final columnName = 'name';
  final columnValue = 'value';

  UserDatabaseHelper.constructor(): super(_databaseName, _databaseVersion);

  static final UserDatabaseHelper instance = UserDatabaseHelper.constructor();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<String> createDir() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return path;
  }

  @override
  String entityTable() => '''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnValue INTEGER NOT NULL
          )
          ''';

  @override
  Future<void> onCreate(Database db, int version) async{
    await db.execute(entityTable());
  }

  Future<Database> _initDatabase() async {
    var path = await createDir();
    return openDatabase(path,
        version: _databaseVersion,
        onCreate: onCreate);
  }
}