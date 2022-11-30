import 'package:equatable/equatable.dart';
import 'package:submission_final/domain/entities/restaurant.dart';

class Favorite extends Equatable {
  const Favorite({
    required this.id,
    required this.name,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  final String? id;
  final String? name;
  final String? pictureId;
  final String? city;
  final double? rating;

  Restaurant toRestaurantEntity() => Restaurant(
        id: id,
        name: name,
        pictureId: pictureId,
        city: city,
        rating: rating,
      );

  factory Favorite.fromRestaurantEntity({required Restaurant data}) => Favorite(
        id: data.id,
        name: data.name,
        pictureId: data.pictureId,
        city: data.city,
        rating: data.rating,
      );

  @override
  List<Object?> get props => [id, name, pictureId, city, rating];
}
