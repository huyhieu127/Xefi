import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xefi/src/data/repositories/local/shared_preferences/shared_preferences_manager.dart';
import 'package:xefi/src/domain/entities/user/user_entity.dart';

class SharedPreferencesManagerImpl implements SharedPreferencesManager {
  final SharedPreferences prefs;

  SharedPreferencesManagerImpl(this.prefs);

  @override
  bool getLogged() {
    return prefs.getBool("logged") ?? false;
  }

  @override
  Future<void> setLogged({required bool isLogged}) async {
    await prefs.setBool("logged", isLogged);
  }

  @override
  UserEntity? loadUser() {
    try {
      var data = prefs.getString("user");
      return (data != null && data.isNotEmpty)
          ? UserEntity.fromJson(jsonDecode(data))
          : null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveUser({required UserEntity? user}) async {
    if(user == null){
      return;
    }
    await prefs.setString("user", jsonEncode(user.toJson()));
  }
}
