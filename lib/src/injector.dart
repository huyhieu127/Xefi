import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xefi/src/config/router/app_router.dart';
import 'package:xefi/src/core/network/dio/dio_client.dart';
import 'package:xefi/src/data/data_sources/firebase/firestore_datasource.dart';
import 'package:xefi/src/data/data_sources/firebase/firestore_datasource_impl.dart';
import 'package:xefi/src/data/data_sources/remote/movie/movie_datasource.dart';
import 'package:xefi/src/data/data_sources/remote/movie/movie_datasource_impl.dart';
import 'package:xefi/src/data/repositories/firebase/firestore_repository_impl.dart';
import 'package:xefi/src/data/repositories/remote/movie/movie_repository_impl.dart';
import 'package:xefi/src/data/repositories/shared_preferences/shared_preferences_manager_impl.dart';
import 'package:xefi/src/domain/repositories/firebase/firestore_repository.dart';
import 'package:xefi/src/domain/repositories/remote/movie/movie_repository.dart';
import 'package:xefi/src/domain/repositories/shared_preferences/shared_preferences_manager.dart';
import 'package:xefi/src/domain/usecases/firebase/firestore_usecases.dart';
import 'package:xefi/src/domain/usecases/network/movie/movie_usecases.dart';
import 'package:xefi/src/presentation/cubit/cubit_injections.dart';

final injector = GetIt.instance;

Future<void> initGetItInjections() async {
  final prefs = await SharedPreferences.getInstance();
  injector
    //AppRoute
    ..registerLazySingleton<AppRouter>(() => AppRouter())
    //Firestore
    ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
    //Shared Preferences
    ..registerLazySingleton<SharedPreferencesManager>(
        () => SharedPreferencesManagerImpl(prefs))

    // Network
    ..registerLazySingleton<DioClient>(DioClient.new)
    // Database

    // Datasource
    ..registerLazySingleton<MovieDatasource>(
        () => MovieDatasourceImpl(injector()))
    ..registerLazySingleton<FirestoreDatasource>(
        () => FirestoreDatasourceImpl(injector(), injector()))

    // Repositories
    ..registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(injector()))
    ..registerLazySingleton<FirestoreRepository>(
        () => FirestoreRepositoryImpl(injector()))

    // UseCases
    ..registerLazySingleton<MovieUseCases>(() => MovieUseCases(injector()))
    ..registerLazySingleton<FirestoreUsecases>(
        () => FirestoreUsecases(injector()));
  //Cubit
  cubitInjections();
}

SharedPreferencesManager get prefs => injector<SharedPreferencesManager>();
