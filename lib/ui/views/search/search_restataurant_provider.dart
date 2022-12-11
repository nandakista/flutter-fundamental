import 'package:flutter/cupertino.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/domain/usecases/search_restaurant.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final SearchRestaurant searchRestaurant;
  SearchRestaurantProvider({required this.searchRestaurant});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.initial;
  RequestState get state => _state;
  List<Restaurant> _data = <Restaurant>[];
  List<Restaurant> get data => _data;

  SearchRestaurantProvider init() {
    _state = RequestState.initial;
    return this;
  }

  void toInitial() {
    _state = RequestState.initial;
   notifyListeners();
  }

  Future<void> onSearchRestaurant(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchRestaurant(query: query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        if (data.isEmpty) {
          _state = RequestState.empty;
          _message = 'Oops we could not find what you were looking for!';
          notifyListeners();
        } else {
          _data = data;
          _state = RequestState.success;
          notifyListeners();
        }
      },
    );
  }
}
