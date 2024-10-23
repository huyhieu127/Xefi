import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:xefi/src/data/data_sources/firebase/firestore_datasource.dart';
import 'package:xefi/src/domain/repositories/firebase/firestore_repository.dart';

class FirestoreRepositoryImpl implements FirestoreRepository {
  final FirestoreDatasource _firestoreDatasource;

  FirestoreRepositoryImpl(this._firestoreDatasource);

  @override
  Stream<bool> getFavorite({required String slugName}) {
    return _firestoreDatasource.getFavorite(slugName: slugName);
  }

  @override
  Future<Either<Exception, bool>> saveFavorite(
      {required String slugName, required bool isFavorite}) async {
    try {
      Exception? ex;
      await _firestoreDatasource
          .saveFavorite(
            slugName: slugName,
            isFavorite: isFavorite,
          )
          .onError((e, _) => ex = Exception("Error writing document: $e"));
      return ex != null ? Left(ex!) : const Right(true);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
