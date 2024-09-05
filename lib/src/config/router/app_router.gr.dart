// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:xefi/src/core/utils/enums/movie_genre.dart' as _i7;
import 'package:xefi/src/presentation/pages/home/home_page.dart' as _i1;
import 'package:xefi/src/presentation/pages/list_movie/list_movie_page.dart'
    as _i2;
import 'package:xefi/src/presentation/pages/play_movie/play_movie_page.dart'
    as _i3;
import 'package:xefi/src/presentation/pages/search/search_page.dart' as _i4;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.ListMoviePage]
class ListMovieRoute extends _i5.PageRouteInfo<ListMovieRouteArgs> {
  ListMovieRoute({
    _i6.Key? key,
    required _i7.MovieGenre movieGenre,
    required String title,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          ListMovieRoute.name,
          args: ListMovieRouteArgs(
            key: key,
            movieGenre: movieGenre,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'ListMovieRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ListMovieRouteArgs>();
      return _i2.ListMoviePage(
        key: args.key,
        movieGenre: args.movieGenre,
        title: args.title,
      );
    },
  );
}

class ListMovieRouteArgs {
  const ListMovieRouteArgs({
    this.key,
    required this.movieGenre,
    required this.title,
  });

  final _i6.Key? key;

  final _i7.MovieGenre movieGenre;

  final String title;

  @override
  String toString() {
    return 'ListMovieRouteArgs{key: $key, movieGenre: $movieGenre, title: $title}';
  }
}

/// generated route for
/// [_i3.PlayMoviePage]
class PlayMovieRoute extends _i5.PageRouteInfo<PlayMovieRouteArgs> {
  PlayMovieRoute({
    _i6.Key? key,
    required String slug,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          PlayMovieRoute.name,
          args: PlayMovieRouteArgs(
            key: key,
            slug: slug,
          ),
          initialChildren: children,
        );

  static const String name = 'PlayMovieRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlayMovieRouteArgs>();
      return _i3.PlayMoviePage(
        key: args.key,
        slug: args.slug,
      );
    },
  );
}

class PlayMovieRouteArgs {
  const PlayMovieRouteArgs({
    this.key,
    required this.slug,
  });

  final _i6.Key? key;

  final String slug;

  @override
  String toString() {
    return 'PlayMovieRouteArgs{key: $key, slug: $slug}';
  }
}

/// generated route for
/// [_i4.SearchPage]
class SearchRoute extends _i5.PageRouteInfo<void> {
  const SearchRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SearchPage();
    },
  );
}
