import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_final/core/db/shared_prefs_key.dart';
import 'package:submission_final/initializer.dart';

import '../../../core/utils/background_service.dart';
import '../../../core/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  late bool _isScheduled;
  final prefs = sl<SharedPreferences>();

  bool get isScheduled => _isScheduled;

  SchedulingProvider init() {
    _isScheduled = prefs.getBool(SharedPrefsKey.isActiveReminder) ?? false;
    notifyListeners();
    return this;
  }

  setScheduling(bool value) {
    _isScheduled = value;
    prefs.setBool(SharedPrefsKey.isActiveReminder, value);
  }

  Future<bool> scheduledRestaurant(bool value) async {
    setScheduling(value);
    if (_isScheduled) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
