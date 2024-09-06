import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/cubit/home/get_animation/get_animation_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_movie_series/get_movie_series_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_newest/get_newest_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_single_movie/get_single_movie_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_tv_shows/get_tv_shows_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/home_cubit.dart';
import 'package:xefi/src/presentation/cubit/list_movie/list_movie_cubit.dart';
import 'package:xefi/src/presentation/cubit/play_movie/get_detail/get_detail_cubit.dart';
import 'package:xefi/src/presentation/cubit/play_movie/play_movie_cubit.dart';

Future<void> cubitInjections() async {
  //Home
  injector
    ..registerFactory<HomeCubit>(() => HomeCubit())
    ..registerFactory<GetNewestCubit>(() => GetNewestCubit(injector()))
    ..registerFactory<GetAnimationCubit>(
        () => GetAnimationCubit(injector()))
    ..registerFactory<GetMovieSeriesCubit>(
        () => GetMovieSeriesCubit(injector()))
    ..registerFactory<GetSingleMovieCubit>(
        () => GetSingleMovieCubit(injector()))
    ..registerFactory<GetTvShowsCubit>(() => GetTvShowsCubit(injector()));

  //ListMovie
  injector.registerFactory<ListMovieCubit>(() => ListMovieCubit(injector()));

  //PlayMovie
  injector
    ..registerFactory<PlayMovieCubit>(() => PlayMovieCubit())
    ..registerFactory<GetDetailCubit>(() => GetDetailCubit(injector()));
}
