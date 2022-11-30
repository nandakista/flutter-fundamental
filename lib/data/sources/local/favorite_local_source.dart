import 'package:submission_final/domain/entities/favorite.dart';

abstract class FavoriteLocalSource {
  Future<String> insertFavorite(Favorite restaurant);
  Future<String> removeFavorite(Favorite restaurant);
  Future<Favorite?> getFavorite(int id);
  Future<List<Favorite>> getAllFavorite();
}