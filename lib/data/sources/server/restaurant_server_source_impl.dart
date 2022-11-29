import 'dart:convert';

import 'package:submission_final/core/constant/constant.dart';
import 'package:submission_final/core/error/exception.dart';
import 'package:submission_final/data/models/restaurant_model.dart';
import 'package:submission_final/data/sources/server/restaurant_server_source.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:http/http.dart' as http;

import '../../models/wrapper/restaurant_wrapper.dart';

class RestaurantServerSourceImpl implements RestaurantServerSource {
  final http.Client client;

  RestaurantServerSourceImpl({required this.client});

  @override
  Future<Restaurant> getDetailRestaurant({required String id}) async {
    final response = await client.get(
      Uri.parse('${Constant.baseUrl}/detail/$id'),
    );
    if (response.statusCode == 200) {
      return RestaurantModel.fromJson(json.decode(response.body)['restaurant']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Restaurant>> getListRestaurant() async {
    final response = await client.get(Uri.parse('${Constant.baseUrl}/list'));
    if (response.statusCode == 200) {
      return RestaurantWrapper.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Restaurant>> searchRestaurant({required String query}) async {
    final response = await client.get(
      Uri.parse('${Constant.baseUrl}/search?q=$query'),
    );
    if (response.statusCode == 200) {
      return RestaurantWrapper.fromJson(json.decode(response.body)).data;
    } else {
      throw ServerException();
    }
  }
}
