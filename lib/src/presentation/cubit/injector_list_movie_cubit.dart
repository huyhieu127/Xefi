import 'package:get_it/get_it.dart';
import 'package:xefi/src/presentation/cubit/home/get_animation/get_animation_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_movie_series/get_movie_series_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_newest/get_newest_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_single_movie/get_single_movie_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_tv_shows/get_tv_shows_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/home_cubit.dart';
import 'package:xefi/src/presentation/cubit/list_movie/list_movie_cubit.dart';

final injectorListMovie = GetIt.instance;

Future<void> initListMovieCubitInjections() async {
  injectorListMovie
    .registerFactory<ListMovieCubit>(() => ListMovieCubit(injectorListMovie()));
}
