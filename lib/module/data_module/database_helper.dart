// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'thoughts.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE thoughts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        category TEXT,
        datetime TEXT
      )
    ''');
  }

  Future<int> addThought(String title, String description, String category, DateTime dateTime) async {
    Database db = await database;
    return await db.insert('thoughts', {
      'title': title,
      'description': description,
      'category': category,
      'datetime': dateTime.toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getThoughts() async {
    Database db = await database;
    return await db.query('thoughts');
  }

  Future<int> deleteThought(int id) async {
    Database db = await database;
    return await db.delete('thoughts', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateThought(int id, String title, String description, String category, DateTime dateTime) async {
    Database db = await database;
    return await db.update('thoughts', {
      'title': title,
      'description': description,
      'category': category,
      'datetime': dateTime.toIso8601String(),
    }, where: 'id = ?', whereArgs: [id]);
  }
}
