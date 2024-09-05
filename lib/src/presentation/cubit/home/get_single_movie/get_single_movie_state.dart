part of 'get_single_movie_cubit.dart';

sealed class GetSingleMovieState extends Equatable {
  const GetSingleMovieState();

  @override
  List<Object?> get props => [];
}

final class GetSingleMovieInitial extends GetSingleMovieState {}

final class GetSingleMovieLoading extends GetSingleMovieState {
  const GetSingleMovieLoading();
}

final class GetSingleMovieSuccess extends GetSingleMovieState {
  final MovieGenreDataEntity? movieGenreDataEntity;

  const GetSingleMovieSuccess({required this.movieGenreDataEntity});

  @override
  List<Object?> get props => [movieGenreDataEntity];
}

final class GetSingleMovieError extends GetSingleMovieState {
  final String message;

  const GetSingleMovieError({required this.message});

  @override
  List<Object> get props => [message];
}
