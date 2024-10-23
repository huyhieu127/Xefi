import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xefi/src/data/data_sources/firebase/firestore_datasource.dart';
import 'package:xefi/src/domain/repositories/shared_preferences/shared_preferences_manager.dart';

class FirestoreDatasourceImpl implements FirestoreDatasource {
  final FirebaseFirestore _firestore;
  final SharedPreferencesManager _prefs;

  FirestoreDatasourceImpl(this._firestore, this._prefs);

  String get _uid => _prefs.loadUser()?.uid ?? "";

  CollectionReference get _collectionUid => _firestore.collection(_uid);

  @override
  Stream<bool> getFavorite({required String slugName}) {
    if (_uid.isEmpty || slugName.isEmpty) {
      return Stream.value(false);
    } else {
      return _collectionUid.doc(slugName).snapshots().map((snapshot) {
        return snapshot["isFavorite"];
      });
    }
  }

  @override
  Future<void> saveFavorite(
      {required String slugName, required bool isFavorite}) {
    if (_uid.isEmpty || slugName.isEmpty) {
      return Future.error("Params is Empty!");
    } else {
      return _collectionUid.doc(slugName).set({
              "isFavorite": isFavorite,
            });
      // return isFavorite
      //     ? _collectionUid.doc(slugName).set({
      //         "isFavorite": isFavorite,
      //       })
      //     : _collectionUid.doc(slugName).update({
      //         'isFavorite': FieldValue.delete(), // Xóa field 'isFavorite'
      //       });
    }
  }
}
