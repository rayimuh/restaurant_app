import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import '/utils/background_service.dart';
import '/utils/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  static const String alarmKey='alarmKey';
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  void saveValue() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool(alarmKey, _isScheduled);
  }

  void loadValue() async{
    final prefs=await SharedPreferences.getInstance();
    _isScheduled=prefs.getBool(alarmKey)??false;
    notifyListeners();
  }

  Future<bool> scheduledNotif(bool value) async {
    _isScheduled = value;
    saveValue();

    if (_isScheduled) {
      print('Scheduling News Activated');
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
      print('Scheduling News Canceled');
      saveValue();
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}