part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {
  const SearchLoading();
}

final class SearchSuccess extends SearchState {
  final List<MovieGenreEntity> movies;
  final String domainImage;

  const SearchSuccess({
    required this.movies,
    required this.domainImage,
  });

  @override
  List<Object?> get props => [movies, domainImage];
}

final class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}
