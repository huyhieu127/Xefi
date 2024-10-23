import 'package:xefi/src/domain/entities/user/user_entity.dart';

abstract class SharedPreferencesManager {
  Future<void> setLogged({required bool isLogged});

  bool getLogged();

  Future<void> saveUser({required UserEntity? user});

  UserEntity? loadUser();
}
