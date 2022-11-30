import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:submission_final/data/sources/server/restaurant_server_source.dart';
import 'package:submission_final/domain/repositories/restaurant_repository.dart';
import 'package:submission_final/domain/usecases/search_restaurant.dart';
import 'package:submission_final/ui/views/detail/restaurant_detail_provider.dart';
import 'package:submission_final/ui/views/home/restaurant_list_provider.dart';
import 'package:submission_final/ui/views/search/search_restataurant_provider.dart';

import 'core/db/dao/restaurant_dao.dart';
import 'data/repositories/restaurant_repository_impl.dart';
import 'data/sources/local/favorite_local_source.dart';
import 'data/sources/local/favorite_local_source_impl.dart';
import 'data/sources/server/restaurant_server_source_impl.dart';
import 'domain/usecases/get_detail_restaurant.dart';
import 'domain/usecases/get_list_restaurant.dart';

final sl = GetIt.instance;

void init() {
  // Http Client
  sl.registerLazySingleton(() => http.Client());

  // Provider
  sl.registerFactory(
    () => RestaurantListProvider(
      getListRestaurant: sl<GetListRestaurant>(),
    ),
  );
  sl.registerFactory(
    () => RestaurantDetailProvider(
      getDetailRestaurant: sl<GetDetailRestaurant>(),
    ),
  );
  sl.registerFactory(
    () => SearchRestaurantProvider(
      searchRestaurant: sl<SearchRestaurant>(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(
    () => GetDetailRestaurant(
      repository: sl<RestaurantRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => GetListRestaurant(
      repository: sl<RestaurantRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => SearchRestaurant(
      repository: sl<RestaurantRepository>(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      serverSource: sl<RestaurantServerSource>(),
      localSource: sl<FavoriteLocalSource>(),
    ),
  );

  // Sources
  sl.registerLazySingleton<RestaurantServerSource>(
    () => RestaurantServerSourceImpl(
      client: sl<http.Client>(),
    ),
  );
  sl.registerLazySingleton<FavoriteLocalSource>(
    () => FavoriteLocalSourceImpl(
      dao: sl<FavoriteDao>(),
    ),
  );

  // Dao
  sl.registerLazySingleton<FavoriteDao>(() => FavoriteDao());
}
