part of 'get_movie_series_cubit.dart';

sealed class GetMovieSeriesState extends Equatable {
  const GetMovieSeriesState();

  @override
  List<Object?> get props => [];
}

final class GetMovieSeriesInitial extends GetMovieSeriesState {}

final class GetMovieSeriesLoading extends GetMovieSeriesState {
  const GetMovieSeriesLoading();
}

final class GetMovieSeriesSuccess extends GetMovieSeriesState {
  final MovieGenreDataEntity? movieGenreDataEntity;

  const GetMovieSeriesSuccess({required this.movieGenreDataEntity});

  @override
  List<Object?> get props => [movieGenreDataEntity];
}

final class GetMovieSeriesError extends GetMovieSeriesState {
  final String message;

  const GetMovieSeriesError({required this.message});

  @override
  List<Object> get props => [message];
}
