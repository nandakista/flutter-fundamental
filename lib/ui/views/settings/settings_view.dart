import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_final/core/utils/notification_helper.dart';
import 'package:submission_final/data/models/restaurant_model.dart';
import 'package:submission_final/data/models/wrapper/restaurant_wrapper.dart';
import 'package:submission_final/data/sources/server/restaurant_server_source_impl.dart';
import 'package:submission_final/initializer.dart';
import 'package:submission_final/main.dart';
import 'package:submission_final/ui/views/settings/scheduling_provider.dart';
import 'package:submission_final/ui/widgets/content_wrapper.dart';
import 'package:submission_final/ui/widgets/custom_dialog.dart';
import 'package:http/http.dart' as http;

class SettingsView extends StatelessWidget {
  static const route = '/settings';

  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: ContentWrapper(
          top: true,
          marginTop: 12,
          child: Column(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Scheduling News'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: scheduled.isScheduled,
                        onChanged: (value) async {
                          if (Platform.isIOS) {
                            customDialog(context);
                          } else {
                            scheduled.scheduledNews(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final NotificationHelper notificationHelper = NotificationHelper();
                  var result = await RestaurantServerSourceImpl(client: sl<http.Client>()).getListRestaurant();
                  await notificationHelper.showNotification(
                    flutterLocalNotificationsPlugin,
                    RestaurantWrapper(
                      data: result
                          .map(
                            (e) => RestaurantModel(
                          id: e.id,
                          name: e.name,
                          pictureId: e.pictureId,
                          city: e.city,
                          rating: e.rating,
                              description: e.description,
                        ),
                      )
                          .toList(),
                    ),
                  );
                },
                child: const Text('Show Notification'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
