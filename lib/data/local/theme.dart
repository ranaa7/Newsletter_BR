import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:newsletter_blueribbon_task/shared/constants/cached_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;



  Future<void> loadTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isDarkMode.value = prefs.getBool(CachedKeys.darkMode) ?? false;
  Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() async {
  isDarkMode.value = !isDarkMode.value;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(CachedKeys.darkMode, isDarkMode.value);
  Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

}