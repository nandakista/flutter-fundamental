import 'package:submission_final/domain/repositories/restaurant_repository.dart';

class GetFavoriteExistStatus {
  final RestaurantRepository repository;
  GetFavoriteExistStatus({required this.repository});

  Future<bool> call(String id) {
    return repository.hasAddedToFavorite(id);
  }
}