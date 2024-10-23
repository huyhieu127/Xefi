import 'package:dartz/dartz.dart';

abstract class FirestoreRepository {
  //REMOTE
  Stream<bool> getFavorite({
    required String slugName,
  });

  Future<Either<Exception, bool>> saveFavorite({
    required String slugName,
    required bool isFavorite,
  });
}
