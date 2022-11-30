import 'package:submission_final/core/db/dao/restaurant_dao.dart';
import 'package:submission_final/core/error/exception.dart';
import 'package:submission_final/data/models/favorite_model.dart';
import 'package:submission_final/domain/entities/favorite.dart';

import 'favorite_local_source.dart';

class FavoriteLocalSourceImpl extends FavoriteLocalSource {
  final FavoriteDao dao;

  FavoriteLocalSourceImpl({required this.dao});

  @override
  Future<Favorite?> getFavorite(String id) async {
    final result = await dao.getFavorite(id);
    if (result != null) {
      return FavoriteModel.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<Favorite>> getAllFavorite() async {
    try {
      final result = await dao.getAllFavorite();
      return result.map((data) => FavoriteModel.fromJson(data)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertFavorite(Favorite restaurant) async {
    try {
      await dao.insertFavorite(restaurant);
      return 'Added to Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorite(Favorite restaurant) async {
    try {
      await dao.removeFavorite(restaurant);
      return 'Removed from Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
