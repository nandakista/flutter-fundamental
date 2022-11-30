import 'package:sqflite/sqflite.dart';

import '../constant/constant.dart';
import 'dao/restaurant_dao.dart';

class AppDatabase {
  static AppDatabase? _appDatabase;
  AppDatabase._instance() {
    _appDatabase = this;
  }
  factory AppDatabase() => _appDatabase ?? AppDatabase._instance();

  Database? _database;
  Future<Database?> get database async {
    return _database ??= await initDatabase();
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/${Constant.dbName}';
    return await openDatabase(
      databasePath,
      version: Constant.dbVersion,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE ${FavoriteDao.tableName} (
        ${FavoriteDao.id} INTEGER PRIMARY KEY,
        ${FavoriteDao.name} TEXT,
        ${FavoriteDao.pictureId} TEXT,
        ${FavoriteDao.city} TEXT,
        ${FavoriteDao.rating} REAL,
        );
    ''');
  }
}
