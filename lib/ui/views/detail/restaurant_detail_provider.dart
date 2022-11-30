import 'package:flutter/cupertino.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/domain/usecases/get_detail_restaurant.dart';
import 'package:submission_final/domain/usecases/get_favorite_exist_status.dart';
import 'package:submission_final/domain/usecases/remove_favorite.dart';
import 'package:submission_final/domain/usecases/save_favorite.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final GetDetailRestaurant getDetailFavorite;
  final GetFavoriteExistStatus getFavoriteExistStatus;
  final SaveFavorite saveFavorite;
  final RemoveFavorite removeFavorite;

  RestaurantDetailProvider({
    required this.getDetailFavorite,
    required this.getFavoriteExistStatus,
    required this.saveFavorite,
    required this.removeFavorite,
  });

  String _message = '';
  String get message => _message;

  RequestState _detailState = RequestState.initial;
  RequestState get detailState => _detailState;
  late Restaurant _detailData;
  Restaurant get detailData => _detailData;

  Future<void> loadData(String id) async {
    _detailState = RequestState.loading;
    notifyListeners();

    final detailResult = await getDetailFavorite(id: id);
    detailResult.fold(
      (failure) {
        _detailState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _detailData = data;
        _detailState = RequestState.success;
        notifyListeners();
      },
    );
  }

  String _favoriteMessage = '';
  String get favoriteMessage => _favoriteMessage;

  bool _hasAddedToFavorite = false;
  bool get hasAddedToFavorite => _hasAddedToFavorite;

  Future<void> addFavorite(Restaurant restaurant) async {
    final result = await saveFavorite(restaurant);
    await result.fold(
      (failure) async {
        _favoriteMessage = failure.message;
      },
      (message) async {
        _favoriteMessage = message;
      },
    );
    await loadFavoriteExistStatus(restaurant.id!);
  }

  Future<void> removeFromFavorite(Restaurant restaurant) async {
    final result = await removeFavorite(restaurant);
    await result.fold(
      (failure) async {
        _favoriteMessage = failure.message;
      },
      (message) async {
        _favoriteMessage = message;
      },
    );
    await loadFavoriteExistStatus(restaurant.id!);
  }

  Future<void> loadFavoriteExistStatus(String id) async {
    _hasAddedToFavorite = await getFavoriteExistStatus(id);
    notifyListeners();
  }
}
