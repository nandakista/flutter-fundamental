import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:submission_final/data/models/customer_review_model.dart';
import 'package:submission_final/data/models/food_drink_model.dart';
import 'package:submission_final/data/models/menu_model.dart';
import 'package:submission_final/data/models/restaurant_category_model.dart';
import 'package:submission_final/data/models/restaurant_model.dart';
import 'package:submission_final/domain/entities/restaurant.dart';

import '../../core/fixture/fixture_reader.dart';

void main() {
  const tRestaurantModel = RestaurantModel(
    id: 'rqdv5juczeskfw1e867',
    name: 'Melting Pot',
    pictureId: '14',
    description: 'description',
    city: 'Medan',
    rating: 4.2,
    categories: [
      RestaurantCategoryModel(name: 'Italia'),
    ],
    menus: MenuModel(
      foods: [
        FoodDrinkModel(name: 'Paket rosemary'),
      ],
      drinks: [
        FoodDrinkModel(name: 'Es Teh'),
      ],
    ),
    customerReviews: [
      CustomerReviewModel(
        name: 'Ahmad',
        review: 'Tidak rekomendasi untuk pelajar!',
        date: '13 November 2019',
      )
    ],
  );

  test('''Should be a subclass of Tv Entity''', () {
    // Assert
    expect(tRestaurantModel, isA<Restaurant>());
  });

  group('''fromJson''', () {
    test('''Should return a valid model when parsing JSON map''', () {
      // Arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('restaurant.json'),
      );
      // Act
      final result = RestaurantModel.fromJson(jsonMap);
      // Assert
      expect(result, tRestaurantModel);
    });
  });

  group('''toJson''', () {
    test('''Should return a JSON map containing the proper data ''', () {
      // Act
      final result = tRestaurantModel.toJson();
      // Assert
      final expectedMap = json.decode(fixture('restaurant.json'));
      expect(result, expectedMap);
    });
  });
}
