import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:submission_final/core/error/failure.dart';
import 'package:submission_final/data/sources/local/favorite_local_source.dart';
import 'package:submission_final/data/sources/server/restaurant_server_source.dart';
import 'package:submission_final/domain/entities/favorite.dart';

import '../../core/error/exception.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl extends RestaurantRepository {
  final RestaurantServerSource serverSource;
  final FavoriteLocalSource localSource;

  RestaurantRepositoryImpl({
    required this.serverSource,
    required this.localSource,
  });

  @override
  Future<Either<Failure, Restaurant>> getDetailRestaurant({
    required String id,
  }) async {
    try {
      final result = await serverSource.getDetailRestaurant(id: id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getListRestaurant() async {
    try {
      final result = await serverSource.getListRestaurant();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> searchRestaurant({
    required String query,
  }) async {
    try {
      final result = await serverSource.searchRestaurant(query: query);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getAllFavorite() async {
    try {
      final result = await localSource.getAllFavorite();
      return Right(result.map((data) => data.toRestaurantEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> hasAddedToFavorite(int id) async {
    final result = await localSource.getFavorite(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeFavorite(Restaurant restaurant) async {
    try {
      final result = await localSource
          .removeFavorite(Favorite.fromRestaurantEntity(data: restaurant));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveFavorite(Restaurant restaurant) async {
    try {
      final result = await localSource
          .insertFavorite(Favorite.fromRestaurantEntity(data: restaurant));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
