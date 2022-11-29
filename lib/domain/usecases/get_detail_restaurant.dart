import 'package:dartz/dartz.dart';
import 'package:submission_final/core/error/failure.dart';

import '../entities/restaurant.dart';
import '../repositories/restaurant_repository.dart';

class GetDetailRestaurant {
  final RestaurantRepository repository;
  GetDetailRestaurant({required this.repository});

  Future<Either<Failure, Restaurant>> call({required String id}) async {
    return await repository.getDetailRestaurant(id: id);
  }
}