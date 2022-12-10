import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:submission_final/core/utils/notification_helper.dart';
import 'package:submission_final/data/sources/server/restaurant_server_source_impl.dart';
import 'package:submission_final/initializer.dart';
import 'package:submission_final/main.dart';
import 'package:submission_final/ui/views/settings/scheduling_provider.dart';
import 'package:submission_final/ui/widgets/content_wrapper.dart';
import 'package:submission_final/ui/widgets/custom_dialog.dart';

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
                  title: const Text('Scheduling Restaurant'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: scheduled.isScheduled,
                        onChanged: (value) async {
                          if (Platform.isIOS) {
                            customDialog(context);
                          } else {
                            scheduled.scheduledRestaurant(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
