// database_helper.dart
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'building_database.db';
  static final _databaseVersion = 1;

  static final tableBuildings = 'buildings';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnFloors = 'floors';

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // This opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableBuildings (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnFloors INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Insert a building into the database
  Future<int> insertBuilding(String name, int floors) async {
    Database db = await instance.database;
    return await db.insert(tableBuildings, {
      columnName: name,
      columnFloors: floors,
    });
  }

  // Get all buildings from the database
  Future<List<Map<String, dynamic>>> queryAllBuildings() async {
    Database db = await instance.database;
    return await db.query(tableBuildings);
  }
}
