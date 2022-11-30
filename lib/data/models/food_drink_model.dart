import '../../domain/entities/food_drink.dart';

class FoodDrinkModel extends FoodDrink {
  const FoodDrinkModel({String? name}): super(name: name);

  factory FoodDrinkModel.fromJson(Map<String, dynamic> json) => FoodDrinkModel(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}