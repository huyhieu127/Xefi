import 'package:get_it/get_it.dart';
import 'package:xefi/src/presentation/cubit/list_movie/list_movie_cubit.dart';

final injectorListMovie = GetIt.instance;

Future<void> initListMovieCubitInjections() async {
  injectorListMovie.registerLazySingleton<ListMovieCubit>(
      () => ListMovieCubit(injectorListMovie()));
}
