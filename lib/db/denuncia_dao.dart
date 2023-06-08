import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DenunciaDao {
  static const _databaseName = 'projetoAulaAppDenuncia.db';
  static const _databaseVersion = 1;

  static const table = 'denuncias';
  static const columnId = 'id';
  static const columnShortDescription = 'shortDescription';
  static const columnDescription = 'description';
  static const columnImage1 = 'image1';
  static const columnImage2 = 'image2';
  static const columnImage3 = 'image3';
  static const columnActive = 'active';
  static const columnLatitude = 'latitude';
  static const columnLongitude = 'longitude';

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  DenunciaDao._privateConstructor();

  static final DenunciaDao instance = DenunciaDao._privateConstructor();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
           $columnId INTEGER PRIMARY KEY,            
           $columnShortDescription TEXT,
           $columnDescription TEXT,
           $columnImage1 TEXT,
           $columnImage2 TEXT,
           $columnImage3 TEXT,
           $columnActive TEXT,
           $columnLatitude TEXT,
           $columnLongitude TEXT          
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsDesc() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY id DESC');
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> clearDB() async {
    Database db = await instance.database;
    await db.rawQuery('DELETE FROM $table');
  }
}
