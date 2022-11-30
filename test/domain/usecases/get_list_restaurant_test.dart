import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/domain/repositories/restaurant_repository.dart';
import 'package:submission_final/domain/usecases/get_list_restaurant.dart';

import 'get_list_restaurant_test.mocks.dart';

@GenerateMocks([RestaurantRepository])
void main() {
  late GetListRestaurant usecase;
  late MockRestaurantRepository mockRestaurantRepository;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    usecase = GetListRestaurant(repository: mockRestaurantRepository);
  });

  test('''Should get Restaurant List and then 
  return RestaurantList from the repository''', () async {
    final tRestaurantList = <Restaurant>[];
    // Arrange
    when(mockRestaurantRepository.getListRestaurant()).thenAnswer(
      (_) async => Right(tRestaurantList),
    );
    // Act
    final result = await usecase();
    // Assert
    verify(mockRestaurantRepository.getListRestaurant());
    expect(result, Right(tRestaurantList));
    verifyNoMoreInteractions(mockRestaurantRepository);
  });
}
