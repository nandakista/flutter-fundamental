import 'package:flutter/cupertino.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/domain/usecases/get_favorite.dart';

class FavoriteProvider extends ChangeNotifier {
  final GetFavorite getFavorite;
  FavoriteProvider({required this.getFavorite});

  String _message = '';
  String get message => _message;

  List<Restaurant> _data = <Restaurant>[];
  List<Restaurant> get data => _data;
  RequestState _state = RequestState.initial;
  RequestState get state => _state;

  Future<void> loadData() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getFavorite();
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        if (data.isEmpty) {
          _state = RequestState.empty;
          _message = 'Empty Favorite';
          notifyListeners();
        } else {
          _state = RequestState.success;
          _data = data;
          notifyListeners();
        }
      },
    );
  }
}
