import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xefi/src/core/network/dio/dio_client.dart';
import 'package:xefi/src/data/data_sources/remote/movie/movie_datasource.dart';
import 'package:xefi/src/data/data_sources/remote/movie/movie_datasource_impl.dart';
import 'package:xefi/src/data/repositories/local/shared_preferences/shared_preferences_manager.dart';
import 'package:xefi/src/data/repositories/local/shared_preferences/shared_preferences_manager_impl.dart';
import 'package:xefi/src/data/repositories/movie/movie_repository_impl.dart';
import 'package:xefi/src/domain/repositories/movie/movie_repository.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';
import 'package:xefi/src/presentation/cubit/cubit_injections.dart';

final injector = GetIt.instance;

Future<void> initGetItInjections() async {
  final prefs = await SharedPreferences.getInstance();
  injector
    //Shared Preferences
    ..registerLazySingleton<SharedPreferencesManager>(
        () => SharedPreferencesManagerImpl(prefs))

    // Network
    ..registerLazySingleton<DioClient>(DioClient.new)
    // Database

    // Datasource
    ..registerLazySingleton<MovieDatasource>(
        () => MovieDatasourceImpl(injector()))

    // Repositories
    ..registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(injector()))

    // UseCases
    ..registerLazySingleton<MovieUseCases>(() => MovieUseCases(injector()));
  //Cubit
  cubitInjections();
}

SharedPreferencesManager get prefs => injector<SharedPreferencesManager>();
