import 'package:get_it/get_it.dart';
import 'package:xefi/src/presentation/cubit/home/get_animation/get_animation_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_movie_series/get_movie_series_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_newest/get_newest_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_single_movie/get_single_movie_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_tv_shows/get_tv_shows_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/home_cubit.dart';

final injectorHome = GetIt.instance;

Future<void> initHomeCubitInjections() async {
  injectorHome
    ..registerFactory<HomeCubit>(() => HomeCubit())
    ..registerFactory<GetNewestCubit>(() => GetNewestCubit(injectorHome()))
    ..registerFactory<GetAnimationCubit>(
        () => GetAnimationCubit(injectorHome()))
    ..registerFactory<GetMovieSeriesCubit>(
        () => GetMovieSeriesCubit(injectorHome()))
    ..registerFactory<GetSingleMovieCubit>(
        () => GetSingleMovieCubit(injectorHome()))
    ..registerFactory<GetTvShowsCubit>(() => GetTvShowsCubit(injectorHome()));
}
