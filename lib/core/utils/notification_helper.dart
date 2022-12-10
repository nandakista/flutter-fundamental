import 'dart:convert';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_final/core/db/shared_prefs_key.dart';
import 'package:submission_final/data/models/restaurant_model.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/initializer.dart';

import 'background_service.dart';
import 'date_time_helper.dart';
import 'navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        final payload = details.payload;
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    Restaurant restaurant,
  ) async {
    String channelId = "1";
    String channelName = "channel_01";
    String channelDescription = "restaurant channel";

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    String titleNotification = "<b>${restaurant.name}</b>";
    String titlePayload =
        'Lets explore this famous restaurant. This restaurant have rating (${restaurant.rating}/5)..';

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titlePayload,
      platformChannelSpecifics,
      payload: json.encode(RestaurantModel(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        rating: restaurant.rating,
      ).toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        final data = RestaurantModel.fromJson(json.decode(payload));
        Navigation.intentWithData(
          route,
          Restaurant(id: data.id, name: data.name),
        );
      },
    );
    configureScheduling();
  }

  void configureScheduling() async {
    final prefs = sl<SharedPreferences>();
    bool isActiveReminder =
        prefs.getBool(SharedPrefsKey.isActiveReminder) ?? false;
    if (isActiveReminder) {
      await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      await AndroidAlarmManager.cancel(1);
    }
  }
}
