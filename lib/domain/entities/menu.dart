import 'package:equatable/equatable.dart';

import 'food_drink.dart';

class Menu extends Equatable {
  const Menu({this.foods, this.drinks});

  final List<FoodDrink>? foods;
  final List<FoodDrink>? drinks;

  @override
  List<Object?> get props => [foods, drinks];
}
