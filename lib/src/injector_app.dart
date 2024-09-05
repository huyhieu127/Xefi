import 'package:get_it/get_it.dart';
import 'package:xefi/src/core/network/dio/dio_client.dart';
import 'package:xefi/src/data/data_sources/remote/movie/movie_datasource.dart';
import 'package:xefi/src/data/data_sources/remote/movie/movie_datasource_impl.dart';
import 'package:xefi/src/data/repositories/movie/movie_repository_impl.dart';
import 'package:xefi/src/domain/repositories/movie/movie_repository.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';
import 'package:xefi/src/presentation/cubit/injector_home_cubit.dart';
import 'package:xefi/src/presentation/cubit/injector_list_movie_cubit.dart';
import 'package:xefi/src/presentation/cubit/injector_play_movie_cubit.dart';

final injector = GetIt.instance;

Future<void> initInjections() async {
  injector
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
  initHomeCubitInjections();
  initPlayMovieCubitInjections();
  initListMovieCubitInjections();
}
