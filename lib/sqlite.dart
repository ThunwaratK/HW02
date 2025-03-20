import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'boon_model.dart';

class Sqlitebase {
  static final Sqlitebase instance = Sqlitebase._init();
  static Database? _database;

  Sqlitebase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('boon.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''  
      CREATE TABLE boon (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        desc TEXT,
        eventDate TEXT NOT NULL,
        startHour TEXT NOT NULL,
        startMinute TEXT NOT NULL,
        location TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertBoon(BoonModel boon) async {
    final db = await database;
    return await db.insert('boon', boon.toMap());
  }


  Future<List<BoonModel>> getBoons() async {
    final db = await database;
    final result = await db.query('boon');
    return result.map((data) => BoonModel.fromMap(data)).toList();
  }


  Future<int> deleteBoon(int id) async {
    final db = await database;
    return db.delete('boon', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateBoon(BoonModel boon) async {
    final db = await database;
    return await db.update(
      'boon',
      boon.toMap(),
      where: 'id = ?',
      whereArgs: [boon.id],
    );
  }
}
