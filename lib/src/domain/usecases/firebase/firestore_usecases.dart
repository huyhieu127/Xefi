import 'package:dartz/dartz.dart';
import 'package:xefi/src/domain/repositories/firebase/firestore_repository.dart';

class FirestoreUsecases {
  final FirestoreRepository _firestoreRepository;

  FirestoreUsecases(this._firestoreRepository);

  Stream<bool> getFavorite({required String slugName}) {
    return _firestoreRepository.getFavorite(slugName: slugName);
  }

  Future<Either<Exception, bool>> saveFavorite(
      {required String slugName, required bool isFavorite}) {
    return _firestoreRepository.saveFavorite(
        slugName: slugName, isFavorite: isFavorite);
  }
}
