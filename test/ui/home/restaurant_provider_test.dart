import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/core/error/failure.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/domain/usecases/get_list_restaurant.dart';
import 'package:submission_final/ui/views/home/restaurant_list_provider.dart';

import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([GetListRestaurant])
void main() {
  late MockGetListRestaurant mockGetListRestaurant;
  late RestaurantListProvider provider;
  late int providerCalledCount;

  setUp(() {
    providerCalledCount = 0;
    mockGetListRestaurant = MockGetListRestaurant();
    provider = RestaurantListProvider(getListRestaurant: mockGetListRestaurant)
      ..addListener(() => providerCalledCount += 1);
  });

  test('''Initial State and data should be empty''', () {
    expect(provider.state, RequestState.initial);
    expect(provider.data, List<Restaurant>.empty());
    expect(provider.message, '');
  });

  test('''Should change state to Loading when usecase is called''', () {
    final tRestaurantList = <Restaurant>[];
    // Arrange
    when(mockGetListRestaurant())
        .thenAnswer((_) async => Right(tRestaurantList));
    // Act
    provider.loadData();
    // Assert
    expect(provider.state, RequestState.loading);
    expect(provider.data, List<Restaurant>.empty());
    expect(provider.message, '');
  });

  test('''Should GET Restaurant List data from usecase and data is not empty
  then change state to Success''', () async {
    final tRestaurantList = [
      const Restaurant(
        id: 'rqdv5juczeskfw1e867',
        name: 'Melting Pot',
        pictureId: '14',
        description: 'description',
        city: 'Medan',
        rating: 4.2,
      ),
    ];
    // Arrange
    when(mockGetListRestaurant())
        .thenAnswer((_) async => Right(tRestaurantList));
    // Act
    await provider.loadData();
    final result = provider.data;
    // Assert
    verify(mockGetListRestaurant());
    assert(result.isNotEmpty);
    expect(provider.state, RequestState.success);
    expect(result, tRestaurantList);
    expect(providerCalledCount, 2);
  });

  test('''Should GET Restaurant List data from usecase and data is empty
  then change state to Empty''', () async {
    final tRestaurantList = <Restaurant>[];
    // Arrange
    when(mockGetListRestaurant())
        .thenAnswer((_) async => Right(tRestaurantList));
    // Act
    await provider.loadData();
    final result = provider.data;
    // Assert
    verify(mockGetListRestaurant());
    assert(result.isEmpty);
    expect(provider.state, RequestState.empty);
    expect(provider.message, 'Empty Restaurant');
    expect(result, tRestaurantList);
    expect(providerCalledCount, 2);
  });

  test('''Should perform GET Restaurant List data from usecase then return
  error when data is failed to load''', () async {
    // Arrange
    when(mockGetListRestaurant()).thenAnswer(
      (_) async => const Left(ServerFailure('')),
    );
    // Act
    await provider.loadData();
    // Assert
    expect(provider.state, RequestState.error);
    expect(provider.message, '');
    expect(provider.data, List<Restaurant>.empty());
    expect(providerCalledCount, 2);
  });

  test('''Should perform Restaurant List data from usecase then return
  error when failed connect to the internet''', () async {
    // Arrange
    when(mockGetListRestaurant()).thenAnswer(
      (_) async => const Left(ConnectionFailure('No Internet Connection')),
    );
    // Act
    await provider.loadData();
    // Assert
    expect(provider.state, RequestState.error);
    expect(provider.message, 'No Internet Connection');
    expect(provider.data, List<Restaurant>.empty());
    expect(providerCalledCount, 2);
  });
}
