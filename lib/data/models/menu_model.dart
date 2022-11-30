import '../../domain/entities/food_drink.dart';
import '../../domain/entities/menu.dart';
import 'food_drink_model.dart';

class MenuModel extends Menu {
  const MenuModel({
    List<FoodDrink>? drinks,
    List<FoodDrink>? foods,
  }) : super(
    drinks: drinks,
    foods: foods,
  );

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    foods: List<FoodDrink>.from(
        json["foods"].map((x) => FoodDrinkModel.fromJson(x))),
    drinks: List<FoodDrink>.from(
        json["drinks"].map((x) => FoodDrinkModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": foods,
    "drinks": drinks,
  };
}
