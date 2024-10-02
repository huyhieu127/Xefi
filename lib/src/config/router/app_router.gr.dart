// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/cupertino.dart' as _i9;
import 'package:flutter/material.dart' as _i11;
import 'package:xefi/src/core/utils/enums/movie_genre.dart' as _i10;
import 'package:xefi/src/presentation/pages/bnb/bnb_page.dart' as _i1;
import 'package:xefi/src/presentation/pages/bnb/components/home/home_page.dart'
    as _i2;
import 'package:xefi/src/presentation/pages/list_movie/list_movie_page.dart'
    as _i3;
import 'package:xefi/src/presentation/pages/login/login_page.dart' as _i4;
import 'package:xefi/src/presentation/pages/play_movie/play_movie_page.dart'
    as _i5;
import 'package:xefi/src/presentation/pages/search/search_page.dart' as _i6;
import 'package:xefi/src/presentation/pages/splash/splash_page.dart' as _i7;

/// generated route for
/// [_i1.BnbPage]
class BnbRoute extends _i8.PageRouteInfo<void> {
  const BnbRoute({List<_i8.PageRouteInfo>? children})
      : super(
          BnbRoute.name,
          initialChildren: children,
        );

  static const String name = 'BnbRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.BnbPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.ListMoviePage]
class ListMovieRoute extends _i8.PageRouteInfo<ListMovieRouteArgs> {
  ListMovieRoute({
    _i9.Key? key,
    required _i10.MovieGenre movieGenre,
    required String title,
    List<_i8.PageRouteInfo>? children,
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

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ListMovieRouteArgs>();
      return _i3.ListMoviePage(
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

  final _i9.Key? key;

  final _i10.MovieGenre movieGenre;

  final String title;

  @override
  String toString() {
    return 'ListMovieRouteArgs{key: $key, movieGenre: $movieGenre, title: $title}';
  }
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginPage();
    },
  );
}

/// generated route for
/// [_i5.PlayMoviePage]
class PlayMovieRoute extends _i8.PageRouteInfo<PlayMovieRouteArgs> {
  PlayMovieRoute({
    _i11.Key? key,
    required String slug,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          PlayMovieRoute.name,
          args: PlayMovieRouteArgs(
            key: key,
            slug: slug,
          ),
          initialChildren: children,
        );

  static const String name = 'PlayMovieRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlayMovieRouteArgs>();
      return _i5.PlayMoviePage(
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

  final _i11.Key? key;

  final String slug;

  @override
  String toString() {
    return 'PlayMovieRouteArgs{key: $key, slug: $slug}';
  }
}

/// generated route for
/// [_i6.SearchPage]
class SearchRoute extends _i8.PageRouteInfo<void> {
  const SearchRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.SearchPage();
    },
  );
}

/// generated route for
/// [_i7.SplashPage]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashPage();
    },
  );
}
