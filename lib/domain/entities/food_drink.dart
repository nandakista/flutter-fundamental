import 'package:equatable/equatable.dart';

class FoodDrink extends Equatable {
  const FoodDrink({this.name});

  final String? name;

  @override
  List<Object?> get props => [name];


}
