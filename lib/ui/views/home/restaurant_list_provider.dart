import 'package:flutter/cupertino.dart';

import '../../../core/constant/request_state.dart';
import '../../../domain/entities/restaurant.dart';
import '../../../domain/usecases/get_list_restaurant.dart';

class RestaurantListProvider extends ChangeNotifier {
  final GetListRestaurant getListRestaurant;
  RestaurantListProvider({required this.getListRestaurant});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.initial;
  RequestState get state => _state;
  List<Restaurant> _data = <Restaurant>[];
  List<Restaurant> get data => _data;

  RestaurantListProvider init() {
    loadData();
    return this;
  }

  Future<void> loadData() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getListRestaurant();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        if (data.isEmpty) {
          _state = RequestState.empty;
          _message = 'Empty Restaurant';
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
