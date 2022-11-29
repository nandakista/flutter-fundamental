import 'package:dartz/dartz.dart';
import 'package:submission_final/core/error/failure.dart';

import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

class SearchRestaurant {
  final RestaurantRepository repository;
  SearchRestaurant({required this.repository});

  Future<Either<Failure, List<Restaurant>>> call({
    required String query,
  }) async {
    return await repository.searchRestaurant(query: query);
  }
}
