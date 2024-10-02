import 'package:shared_preferences/shared_preferences.dart';
import 'package:xefi/src/data/repositories/local/shared_preferences/shared_preferences_manager.dart';

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
}
