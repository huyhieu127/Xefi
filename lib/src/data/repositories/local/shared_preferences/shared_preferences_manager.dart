abstract class SharedPreferencesManager {
  Future<void> setLogged({required bool isLogged});

  bool getLogged();
}
