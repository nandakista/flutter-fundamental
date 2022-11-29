import '../../../domain/entities/restaurant.dart';

abstract class RestaurantServerSource {
  Future<List<Restaurant>> getListRestaurant();
  Future<Restaurant> getDetailRestaurant({required String id});
  Future<List<Restaurant>> searchRestaurant({required String query});
}