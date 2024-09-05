enum MovieGenre {
  singleMovie(genre: 'phim-le'),
  movieSeries(genre: 'phim-bo'),
  animation(genre: 'hoat-hinh'),
  tvShows(genre: 'tv-shows');

  const MovieGenre({required this.genre});

  final String genre;
}
