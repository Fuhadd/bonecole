import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_data.dart';
import '../../utils/app_logger.dart';
import '../../utils/custom_string.dart';
import 'local_cache.dart';

class LocalCacheImpl implements LocalCache {
  static const userToken = 'userTokenId';
  static const user = "currentUser";

  late SharedPreferences sharedPreferences;

  LocalCacheImpl({
    required this.sharedPreferences,
  });

  @override
  Object? getFromLocalCache(String key) {
    try {
      return sharedPreferences.get(key);
    } catch (e) {
      AppLogger.log(e);
    }
    return null;
  }

  @override
  Future<void> removeFromLocalCache(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> saveToLocalCache({required String key, required value}) async {
    AppLogger.log('Data being saved: key: $key, value: $value');

    if (value is String) {
      await sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    }
    if (value is Map) {
      await sharedPreferences.setString(key, json.encode(value));
    }
  }

  @override
  UserDataModel getUserData() {
    var res = getFromLocalCache(ConstantString.userJson) as String? ?? '{}';

    return UserDataModel.fromJson(json.decode(res) as Map<String, dynamic>);
  }

  // @override
  // Future<void> cacheUserData({required String value}) async {
  //   await saveToLocalCache(key: user, value: value);
  // }

  // @override
  // Future<void> deleteUserData() async {
  //   await removeFromLocalCache(user);
  // }
}
