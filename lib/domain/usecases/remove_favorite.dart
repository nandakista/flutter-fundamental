import 'package:dartz/dartz.dart';
import 'package:submission_final/core/error/failure.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/domain/repositories/restaurant_repository.dart';

class RemoveFavorite {
  final RestaurantRepository repository;
  RemoveFavorite({required this.repository});

  Future<Either<Failure, String>> call(Restaurant restaurant) {
    return repository.removeFavorite(restaurant);
  }
}
