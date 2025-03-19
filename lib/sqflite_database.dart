import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'boon_model.dart';

class SqfliteDatabase {
  static final SqfliteDatabase _instance = SqfliteDatabase._internal();
  factory SqfliteDatabase() => _instance;

  SqfliteDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'boon_list.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE boon(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            desc TEXT,
            eventDate TEXT NOT NULL,
            startHour TEXT NOT NULL,
            startMinute TEXT NOT NULL,
            location TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<BoonModel>> getBoonList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('boon');

    return List.generate(maps.length, (i) {
      return BoonModel.fromMap(maps[i]);
    });
  }

  Stream<List<BoonModel>> getBoonListStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1)); // Polling interval
      yield await getBoonList();
    }
  }

  Future<void> insertBoon(BoonModel boon) async {
    final db = await database;
    await db.insert(
      'boon',
      boon.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBoon(int id) async {
    final db = await database;
    await db.delete('boon', where: 'id = ?', whereArgs: [id]);
  }

  // Helper method to check if the app is running on a desktop platform
  static bool isDesktopPlatform() {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }
}
