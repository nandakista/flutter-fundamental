import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:submission_final/data/sources/server/restaurant_server_source_impl.dart';
import 'package:submission_final/main.dart';

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
    final NotificationHelper notificationHelper = NotificationHelper();
    final result = await RestaurantServerSourceImpl(client: http.Client())
        .getListRestaurant();
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result[Random().nextInt(result.length)],
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
