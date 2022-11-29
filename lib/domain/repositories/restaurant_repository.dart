import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getListRestaurant();
  Future<Either<Failure, Restaurant>> getDetailRestaurant({required String id});
  Future<Either<Failure, List<Restaurant>>> searchRestaurant({
    required String query,
  });
}
