import '../../domain/entities/customer_review.dart';
import '../../domain/entities/menu.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/restaurant_category.dart';
import 'customer_review_model.dart';
import 'menu_model.dart';
import 'restaurant_category_model.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    String? id,
    String? name,
    String? description,
    String? pictureId,
    String? city,
    double? rating,
    Menu? menus,
    List<RestaurantCategory>? categories,
    List<CustomerReview>? customerReviews,
  }) : super(
          id: id,
          name: name,
          description: description,
          city: city,
          rating: rating,
          pictureId: pictureId,
          menus: menus,
          categories: categories,
          customerReviews: customerReviews,
        );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: (json["rating"] != null) ? json["rating"].toDouble() : null,
        menus:
            (json["menus"] != null) ? MenuModel.fromJson(json["menus"]) : null,
        categories: (json["categories"] != null)
            ? List<RestaurantCategory>.from(json["categories"]
                .map((x) => RestaurantCategoryModel.fromJson(x)))
            : null,
        customerReviews: (json["customerReviews"] != null)
            ? List<CustomerReview>.from(json["customerReviews"]
                .map((x) => CustomerReviewModel.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": MenuModel(drinks: menus?.drinks, foods: menus?.foods).toJson(),
        "categories": List<dynamic>.from(
          categories?.map(
                  (x) => RestaurantCategoryModel(name: x.name).toJson()) ??
              [],
        ),
        "customerReviews": List<dynamic>.from(
          customerReviews?.map((x) => CustomerReviewModel(
                      name: x.name, review: x.review, date: x.date)
                  .toJson()) ??
              [],
        ),
      };
}
