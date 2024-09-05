part of 'list_movie_cubit.dart';

sealed class ListMovieState extends Equatable {
  const ListMovieState();

  @override
  List<Object?> get props => [];
}

final class ListMovieInitial extends ListMovieState {}

final class ListMovieLoading extends ListMovieState {
  const ListMovieLoading();
}

final class ListMovieSuccess extends ListMovieState {
  final MovieGenreDataEntity? movieGenreDataEntity;

  const ListMovieSuccess({required this.movieGenreDataEntity});

  @override
  List<Object?> get props => [movieGenreDataEntity];
}

final class ListMovieError extends ListMovieState {
  final String message;

  const ListMovieError({required this.message});

  @override
  List<Object> get props => [message];
}
