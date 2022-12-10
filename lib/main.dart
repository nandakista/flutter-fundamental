import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:submission_final/initializer.dart' as di;
import 'package:submission_final/ui/views/detail/restaurant_detail_provider.dart';
import 'package:submission_final/ui/views/detail/restaurant_detail_view.dart';
import 'package:submission_final/ui/views/favorite/favorite_provider.dart';
import 'package:submission_final/ui/views/favorite/favorite_view.dart';
import 'package:submission_final/ui/views/home/restaurant_list_provider.dart';
import 'package:submission_final/ui/views/search/search_restataurant_provider.dart';
import 'package:submission_final/ui/views/search/search_restaurant_view.dart';
import 'package:submission_final/ui/views/settings/scheduling_provider.dart';
import 'package:submission_final/ui/views/settings/settings_view.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/background_service.dart';
import 'core/utils/navigation.dart';
import 'core/utils/notification_helper.dart';
import 'core/utils/route_observer.dart';
import 'domain/entities/restaurant.dart';
import 'ui/views/home/restaurant_list_view.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
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
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider().init(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Fundamental',
        theme: AppTheme.build(),
        home: const RestaurantListView(),
        navigatorObservers: [routeObserver],
        navigatorKey: navigatorKey,
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
              return MaterialPageRoute(builder: (_) => const FavoriteView());
            case SettingsView.route:
              return MaterialPageRoute(builder: (_) => const SettingsView());
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
