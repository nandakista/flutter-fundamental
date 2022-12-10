import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_final/core/error/exception.dart';
import 'package:submission_final/data/models/wrapper/restaurant_wrapper.dart';
import 'package:submission_final/data/sources/server/restaurant_server_source_impl.dart';

import '../../../core/fixture/fixture_reader.dart';
import 'restaurant_server_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const baseUrl = 'https://restaurant-api.dicoding.dev';

  late RestaurantServerSourceImpl source;
  late MockClient client;

  setUp(() {
    client = MockClient();
    source = RestaurantServerSourceImpl(client: client);
  });

  tearDown(() {
    client.close();
  });

  group('''GET List Restaurant''', () {
    final dummyRestaurantList =
        RestaurantWrapper.fromJson(json.decode(fixture('restaurant_list.json')))
            .data;

    test(
      '''Should perform GET List Restaurant from Server, 
    then return list of Movie when status code 200 and error is empty''',
      () async {
        // Arrange
        when(client.get(Uri.parse('$baseUrl/list'))).thenAnswer(
          (_) async => http.Response(fixture('restaurant_list.json'), 200),
        );
        // Act
        final result = await source.getListRestaurant();
        // Assert
        expect(result, equals(dummyRestaurantList));
      },
    );

    test(
      '''Should perform GET List Restaurant from Server, 
    then throw ServerException when status code is not 200''',
      () async {
        // Arrange
        when(client.get(Uri.parse('$baseUrl/list'))).thenAnswer(
          (_) async => http.Response('Error', 400),
        );
        // Act
        final result = source.getListRestaurant();
        // Assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
