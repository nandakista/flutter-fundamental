import 'dart:ui';
import 'dart:isolate';
import 'package:submission_final/data/models/restaurant_model.dart';
import 'package:submission_final/data/models/wrapper/restaurant_wrapper.dart';
import 'package:submission_final/data/sources/server/restaurant_server_source_impl.dart';
import 'package:submission_final/initializer.dart';
import 'package:submission_final/main.dart';
import 'package:http/http.dart' as http;

import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    final result = await RestaurantServerSourceImpl(client: sl<http.Client>())
        .getListRestaurant();
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      RestaurantWrapper(
        data: result
            .map(
              (e) => RestaurantModel(
                name: e.name,
                pictureId: e.pictureId,
                id: e.pictureId,
                city: e.city,
                rating: e.rating,
              ),
            )
            .toList(),
      ),
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
