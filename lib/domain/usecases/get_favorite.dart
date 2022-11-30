import 'package:dartz/dartz.dart';
import 'package:submission_final/core/error/failure.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/domain/repositories/restaurant_repository.dart';

class GetFavorite {
  final RestaurantRepository repository;
  GetFavorite({required this.repository});

  Future<Either<Failure, List<Restaurant>>> call() {
    return repository.getAllFavorite();
  }
}