import 'package:equatable/equatable.dart';

import 'customer_review.dart';
import 'menu.dart';
import 'restaurant_category.dart';

class Restaurant extends Equatable {
  const Restaurant({
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

  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;
  final Menu? menus;
  final List<RestaurantCategory>? categories;
  final List<CustomerReview>? customerReviews;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        rating,
        menus,
        categories,
        customerReviews,
      ];
}
