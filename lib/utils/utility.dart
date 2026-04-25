import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class Utility {
  static SharedPreferences? _preference;
  static Future initSharedPrefs() async =>
      _preference = await SharedPreferences.getInstance();

  static dynamic getSharedPreference(String key) {
    if (_preference == null) return null;
    return _preference!.get(key);
  }

  static Future<bool> setSharedPreference(String key, dynamic value) async {
    if (_preference == null) return false;
    if (value is String) return await _preference!.setString(key, value);
    if (value is int) return await _preference!.setInt(key, value);
    if (value is bool) return await _preference!.setBool(key, value);
    if (value is double) return await _preference!.setDouble(key, value);
    return false;
  }

  static Future<bool> removeSharedPreference(String key) async {
    if (_preference == null) return false;
    return await _preference!.remove(key);
  }

  static Future<bool> clearSharedPreference() async {
    if (_preference == null) return false;
    return await _preference!.clear();
  }

  static Future<bool> checkSharedPreference(String key) async {
    if (_preference == null) return false;
    return _preference!.containsKey(key);
  }

  final logger = Logger(
    printer: PrettyPrinter(methodCount: 1, colors: true, printEmojis: true),
  );
}
