
abstract class FirestoreDatasource {
  Stream<bool> getFavorite({
    required String slugName,
  });

  Future<void> saveFavorite({
    required String slugName,
    required bool isFavorite,
  });
}
