import 'package:flutter/material.dart';
import 'package:katarasa/utils/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

const JWT_TOKEN = 'token';
String TOKEN = '';

class CacheStorage {
  static late SharedPreferences sharedPref;

  static initPref() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  //set string, bool, int, double
  static Future<void> setString(
      {required String key, required dynamic value}) async {
    await sharedPref.setString(key, value);
  }

  static Future<void> setInt(
      {required String key, required dynamic value}) async {
    await sharedPref.setInt(key, value);
  }

  static Future<void> setBool(
      {required String key, required dynamic value}) async {
    await sharedPref.setBool(key, value);
  }

  static Future<void> setDouble(
      {required String key, required dynamic value}) async {
    await sharedPref.setDouble(key, value);
  }

  static Future<void> setStringList(
      {required String key, required List<String> value}) async {
    await sharedPref.setStringList(key, value);
  }

  static void setTokenApi(String token) async {
    await sharedPref.setString(JWT_TOKEN, token);
  }

  static String getTokenApi() {
    return sharedPref.getString(JWT_TOKEN) ?? '';
  }

  //get data string
  static String getString({required String key}) {
    return sharedPref.getString(key) ?? '';
  }

  //get data int
  static dynamic getInt({required String key}) {
    return sharedPref.getString(key);
  }

  //get data bool
  static dynamic getBool({required String key}) {
    return sharedPref.getBool(key);
  }

  static dynamic getDouble({required String key}) {
    return sharedPref.getDouble(key);
  }

  static dynamic getStringList({required String key}) {
    return sharedPref.getStringList(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPref.remove(key);
  }
}

class DeleteToken {
  static Future<void> loadData() async {
    String token = CacheStorage.getTokenApi();
    debugPrint('tokened: $token');
    if (token != '') {
      initTokenHeader(token);
      CacheStorage.removeData(key: JWT_TOKEN).then((value) {
        CacheStorage.setTokenApi('');
        initTokenHeader('');
        print('token remove');
      });
    }
  }
}
