import 'package:submission_final/domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  const FavoriteModel({
    String? id,
    String? name,
    String? pictureId,
    String? city,
    double? rating,
  }) : super(
          id: id,
          name: name,
          pictureId: pictureId,
          rating: rating,
          city: city,
        );

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json['id'],
        name: json['name'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
      };
}
