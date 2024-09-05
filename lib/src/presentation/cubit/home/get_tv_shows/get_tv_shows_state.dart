part of 'get_tv_shows_cubit.dart';

sealed class GetTvShowsState extends Equatable {
  const GetTvShowsState();

  @override
  List<Object?> get props => [];
}

final class GetTvShowsInitial extends GetTvShowsState {}

final class GetTvShowsLoading extends GetTvShowsState {
  const GetTvShowsLoading();
}

final class GetTvShowsSuccess extends GetTvShowsState {
  final MovieGenreDataEntity? movieGenreDataEntity;

  const GetTvShowsSuccess({required this.movieGenreDataEntity});

  @override
  List<Object?> get props => [movieGenreDataEntity];
}

final class GetTvShowsError extends GetTvShowsState {
  final String message;

  const GetTvShowsError({required this.message});

  @override
  List<Object> get props => [message];
}
