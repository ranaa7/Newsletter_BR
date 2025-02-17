import 'package:flutter/material.dart';

import '../../../models/pref_model.dart';

class CategoriesProvider extends ChangeNotifier {
  final NotificationSetting allowNotifications =
  NotificationSetting(title: 'Select All preferences');

  final List<NotificationSetting> notifications = [
    NotificationSetting(title: 'Sports'),
    NotificationSetting(title: 'Technology'),
    NotificationSetting(title: 'Health'),
    NotificationSetting(title: 'Other'),
  ];

  List<String> selectedPreferences = [];

  void toggleAllPreferences() {
    final newValue = !allowNotifications.value;
    allowNotifications.value = newValue;

    for (var notification in notifications) {
      notification.value = newValue;
      if (newValue) {
        if (!selectedPreferences.contains(notification.title)) {
          selectedPreferences.add(notification.title);
        }
      } else {
        selectedPreferences.clear();
      }
    }
    notifyListeners();
  }

  void togglePreference(NotificationSetting notification) {
    final newValue = !notification.value;
    notification.value = newValue;

    if (newValue) {
      selectedPreferences.add(notification.title);
    } else {
      selectedPreferences.remove(notification.title);
      allowNotifications.value = false;
    }

    final allSelected = notifications.every((n) => n.value);
    if (allSelected) {
      allowNotifications.value = true;
    }

    notifyListeners();
  }
}
