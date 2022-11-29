import 'package:equatable/equatable.dart';
import 'package:submission_final/data/models/restaurant_model.dart';

class RestaurantWrapper extends Equatable {
  final List<RestaurantModel> data;

  const RestaurantWrapper({required this.data});

  factory RestaurantWrapper.fromJson(Map<String, dynamic> json) =>
      RestaurantWrapper(
        data: List<RestaurantModel>.from(
          (json['restaurants'] as List)
              .map((x) => RestaurantModel.fromJson(x))
              .where((element) => element.pictureId != null),
        ),
      );

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(
          data.map((x) => x.toJson()),
        ),
      };

  @override
  List<Object> get props => [data];
}
