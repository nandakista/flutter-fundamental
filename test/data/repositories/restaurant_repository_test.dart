import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_final/core/error/exception.dart';
import 'package:submission_final/core/error/failure.dart';
import 'package:submission_final/data/repositories/restaurant_repository_impl.dart';
import 'package:submission_final/data/sources/local/favorite_local_source.dart';
import 'package:submission_final/data/sources/server/restaurant_server_source.dart';
import 'package:submission_final/domain/entities/restaurant.dart';

import 'restaurant_repository_test.mocks.dart';

@GenerateMocks([RestaurantServerSource, FavoriteLocalSource])
void main() {
  late RestaurantRepositoryImpl repository;
  late MockRestaurantServerSource mockServerSource;
  late MockFavoriteLocalSource mockLocalSource;

  setUp(() {
    mockServerSource = MockRestaurantServerSource();
    mockLocalSource = MockFavoriteLocalSource();
    repository = RestaurantRepositoryImpl(
      serverSource: mockServerSource,
      localSource: mockLocalSource,
    );
  });

  group('''Get Restaurant List''', () {
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

    test('''Should perform getListRestaurant() then return 
    Restaurant List when the call server source is success ''', () async {
      // Arrange
      when(mockServerSource.getListRestaurant())
          .thenAnswer((_) async => tRestaurantList);
      // Act
      final result = await repository.getListRestaurant();
      // Assert
      verify(mockServerSource.getListRestaurant());
      expect(result, equals(Right(tRestaurantList)));
    });

    test('''Should perform getListRestaurant() then return 
    ServerFailure when the call server source is failed ''', () async {
      // Arrange

      when(mockServerSource.getListRestaurant()).thenThrow(ServerException());
      // Act
      final result = await repository.getListRestaurant();

      // Assert
      verify(mockServerSource.getListRestaurant());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('''Should perform getListRestaurant() then return 
    ConnectionFailure when connection is unstable or no internet''', () async {
      // Arrange
      when(mockServerSource.getListRestaurant())
          .thenThrow(const SocketException('No Internet Connection'));

      // Act
      final result = await repository.getListRestaurant();

      // Assert
      verify(mockServerSource.getListRestaurant());
      expect(
        result,
        equals(
          const Left(ConnectionFailure('No Internet Connection')),
        ),
      );
    });
  });
}
