import 'customer_review.dart';
import 'menu.dart';
import 'restaurant_category.dart';

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
    this.categories,
    this.customerReviews,
  });

  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;
  Menu? menus;
  List<RestaurantCategory>? categories;
  List<CustomerReview>? customerReviews;
}
