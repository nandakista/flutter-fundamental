import '../../domain/entities/restaurant_category.dart';

class RestaurantCategoryModel extends RestaurantCategory {
  RestaurantCategoryModel({String? name}) : super(name: name);

  factory RestaurantCategoryModel.fromJson(Map<String, dynamic> json) =>
      RestaurantCategoryModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
