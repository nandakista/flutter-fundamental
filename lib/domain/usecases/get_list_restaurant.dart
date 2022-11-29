import 'package:dartz/dartz.dart';
import 'package:submission_final/core/error/failure.dart';

import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

class GetListRestaurant {
  final RestaurantRepository repository;
  GetListRestaurant({required this.repository});

  Future<Either<Failure, List<Restaurant>>> call() async {
    return await repository.getListRestaurant();
  }
}