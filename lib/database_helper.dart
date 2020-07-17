import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;

  Future<Database> get database async {
    if (_database == null)
      return _database = await initDB();
    else
      return _database;
  }

  initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, 'dataBase.db');
    bool exists = await databaseExists(path);
    if (!exists) {
      await Directory(dirname(path)).create(recursive: true);
      ByteData data = await rootBundle.load('assets/dataBase.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path, readOnly: true);
  }

  Future<List> getNameOfPhone() async {
    var db = await database;
    return await db.query('phones', columns: ['name'], distinct: true);
  }

  Future<List> getPhone(String name) async {
    var db = await database;
    return await db.query('phones',
        columns: ['phone'], where: 'name = ?', whereArgs: [name]);
  }

  Future<List<Map<String, dynamic>>> getAllCities() async {
    var db = await database;
    return await db.query('trains', columns: ['trainFrom'], distinct: true);
  }

  Future<List> getTrains(String from, String to, String level) async {
    var db = await database;
    return await db.query(
      'trains',
      where: level == ''
          ? 'trainFrom = "$from" And trainTo = "$to"'
          : 'trainFrom = "$from" And trainTo = "$to" And level = "$level"',
    );
  }
}
