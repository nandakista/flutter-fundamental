import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_final/data/sources/server/restaurant_server_source.dart';
import 'package:submission_final/domain/repositories/restaurant_repository.dart';
import 'package:submission_final/domain/usecases/get_favorite.dart';
import 'package:submission_final/domain/usecases/get_favorite_exist_status.dart';
import 'package:submission_final/domain/usecases/remove_favorite.dart';
import 'package:submission_final/domain/usecases/save_favorite.dart';
import 'package:submission_final/domain/usecases/search_restaurant.dart';
import 'package:submission_final/ui/views/detail/restaurant_detail_provider.dart';
import 'package:submission_final/ui/views/favorite/favorite_provider.dart';
import 'package:submission_final/ui/views/home/restaurant_list_provider.dart';
import 'package:submission_final/ui/views/search/search_restataurant_provider.dart';

import 'core/db/dao/restaurant_dao.dart';
import 'data/repositories/restaurant_repository_impl.dart';
import 'data/sources/local/favorite_local_source.dart';
import 'data/sources/local/favorite_local_source_impl.dart';
import 'data/sources/server/restaurant_server_source_impl.dart';
import 'domain/usecases/get_detail_restaurant.dart';
import 'domain/usecases/get_list_restaurant.dart';
import 'ui/views/settings/scheduling_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
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
      getDetailFavorite: sl<GetDetailRestaurant>(),
      getFavoriteExistStatus: sl<GetFavoriteExistStatus>(),
      saveFavorite: sl<SaveFavorite>(),
      removeFavorite: sl<RemoveFavorite>(),
    ),
  );
  sl.registerFactory(
    () => SearchRestaurantProvider(
      searchRestaurant: sl<SearchRestaurant>(),
    ),
  );
  sl.registerFactory(
    () => FavoriteProvider(
      getFavorite: sl<GetFavorite>(),
    ),
  );
  sl.registerFactory(
    () => SchedulingProvider(
      prefs: sl<SharedPreferences>(),
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
  sl.registerLazySingleton(
    () => GetFavorite(
      repository: sl<RestaurantRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => GetFavoriteExistStatus(
      repository: sl<RestaurantRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => SaveFavorite(
      repository: sl<RestaurantRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => RemoveFavorite(
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

  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
