import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:submission_final/core/error/failure.dart';
import 'package:submission_final/data/sources/server/restaurant_server_source.dart';

import '../../core/error/exception.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl extends RestaurantRepository {
  final RestaurantServerSource serverSource;
  RestaurantRepositoryImpl({required this.serverSource});

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
}
