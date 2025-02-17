import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/constants/cached_keys.dart';

class PreferencesProvider extends ChangeNotifier {
  List<String> _selectedInterests = [];

  List<String> get selectedInterests => _selectedInterests;


  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedInterests = prefs.getStringList(CachedKeys.pref) ?? [];
    notifyListeners();
  }

  Future<void> savePreferences(List<String> interests) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(CachedKeys.pref, interests);
    _selectedInterests = interests;
    notifyListeners();
  }
}
