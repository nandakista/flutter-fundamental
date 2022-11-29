import 'package:flutter/cupertino.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/domain/usecases/get_detail_restaurant.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final GetDetailRestaurant getDetailRestaurant;

  RestaurantDetailProvider({
    required this.getDetailRestaurant,
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

    final detailResult = await getDetailRestaurant(id: id);
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
}
