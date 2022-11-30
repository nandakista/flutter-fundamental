import 'package:sqflite/sqflite.dart';
import 'package:submission_final/data/models/favorite_model.dart';
import 'package:submission_final/domain/entities/favorite.dart';

import '../app_database.dart';

class FavoriteDao {
  static const String tableName = 'favorite';
  static const String id = 'id';
  static const String name = 'name';
  static const String pictureId = 'pictureId';
  static const String city = 'city';
  static const String rating = 'rating';

  Future<int> insertFavorite(Favorite restaurant) async {
    Database? db = await AppDatabase().database;
    return await db!.insert(
      tableName,
      FavoriteModel(
        id: restaurant.id,
        name: restaurant.name,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        rating: restaurant.rating,
      ).toJson(),
    );
  }

  Future<int> removeFavorite(Favorite restaurant) async {
    Database? db = await AppDatabase().database;
    return await db!.delete(
      tableName,
      where: '$id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<Map<String, dynamic>?> getFavorite(int id) async {
    Database? db = await AppDatabase().database;
    final result = await db!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllFavorite() async {
    Database? db = await AppDatabase().database;
    final List<Map<String, dynamic>> results = await db!.query(tableName);
    return results;
  }
}