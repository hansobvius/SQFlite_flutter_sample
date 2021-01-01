import 'dart:async';
import 'package:flutter_sqflite_example/app/database/base/database/BaseDatabase.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDatabaseHelper extends BaseDatabase{

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 2;

  static final  String _table = "my_table";
  String get table => _table;

  final columnId = '_id';
  final columnName = 'name';
  final columnValue = 'value';

  UserDatabaseHelper(): super(_databaseName, _databaseVersion, _table);

  static final UserDatabaseHelper instance = UserDatabaseHelper();

  @override
  String entityTable() => '''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnValue INTEGER NOT NULL
          )
          ''';

  @override
  Future<Database> getDatabase() async => getInitDatabase();
}
