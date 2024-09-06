import 'package:get_it/get_it.dart';
import 'package:xefi/src/presentation/cubit/play_movie/get_detail/get_detail_cubit.dart';
import 'package:xefi/src/presentation/cubit/play_movie/play_movie_cubit.dart';

final injectorPlayMovie = GetIt.instance;

Future<void> initPlayMovieCubitInjections() async {
  injectorPlayMovie
    ..registerLazySingleton<PlayMovieCubit>(() => PlayMovieCubit())
    ..registerFactory<GetDetailCubit>(
        () => GetDetailCubit(injectorPlayMovie()));
}

Future<void> resetPlayMovieCubit() async {
  injectorPlayMovie.resetLazySingleton<PlayMovieCubit>();
}