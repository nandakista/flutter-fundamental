import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import 'package:submission_final/initializer.dart' as di;
import 'package:submission_final/ui/views/detail/restaurant_detail_provider.dart';
import 'package:submission_final/ui/views/detail/restaurant_detail_view.dart';
import 'package:submission_final/ui/views/favorite/favorite_provider.dart';
import 'package:submission_final/ui/views/favorite/favorite_view.dart';
import 'package:submission_final/ui/views/home/restaurant_list_provider.dart';
import 'package:submission_final/ui/views/search/search_restataurant_provider.dart';
import 'package:submission_final/ui/views/search/search_restaurant_view.dart';

import 'core/route_observer.dart';
import 'core/theme/app_theme.dart';
import 'domain/entities/restaurant.dart';
import 'ui/views/home/restaurant_list_view.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<RestaurantListProvider>().init(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<RestaurantDetailProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<SearchRestaurantProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<FavoriteProvider>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Fundamental',
        theme: AppTheme.build(),
        home: const RestaurantListView(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case RestaurantListView.route:
              return MaterialPageRoute(
                  builder: (_) => const RestaurantListView());
            case RestaurantDetailView.route:
              final id = settings.arguments as Restaurant;
              return MaterialPageRoute(
                  builder: (_) => RestaurantDetailView(restaurant: id));
            case SearchRestaurantView.route:
              return MaterialPageRoute(
                  builder: (_) => const SearchRestaurantView());
            case FavoriteView.route:
              return MaterialPageRoute(
                  builder: (_) => const FavoriteView());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Oops..\nPage not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
