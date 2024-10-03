import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/core/utils/extension_utils.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/cubit/home/get_animation/get_animation_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_movie_series/get_movie_series_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_newest/get_newest_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_single_movie/get_single_movie_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/get_tv_shows/get_tv_shows_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/home_cubit.dart';
import 'package:xefi/src/presentation/widgets/base_appbar.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/logo_app.dart';

import 'components/home_genre_animation.dart';
import 'components/home_genre_movie_series.dart';
import 'components/home_genre_single_movie.dart';
import 'components/home_genre_tv_shows.dart';
import 'components/home_newest.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => injector<GetNewestCubit>()..getNewest()),
        BlocProvider(
            create: (context) => injector<GetAnimationCubit>()..getAnimation()),
        BlocProvider(
            create: (context) =>
                injector<GetMovieSeriesCubit>()..getMovieSeries()),
        BlocProvider(
            create: (context) =>
                injector<GetSingleMovieCubit>()..getSingleMovie()),
        BlocProvider(
            create: (context) => injector<GetTvShowsCubit>()..getTvShows()),
        BlocProvider(create: (context) => injector<HomeCubit>())
      ],
      child: BaseBackground(
        baseAppBar: BaseAppbar(
          heightAppear: context.screenSize().width / 3,
          child: _appBar(),
        ),
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                HomeNewest(),
                HomeGenreAnimation(movieGenre: MovieGenre.animation),
                SizedBox(height: 16),
                HomeGenreMovieSeries(movieGenre: MovieGenre.movieSeries),
                SizedBox(height: 16),
                HomeGenreSingleMovie(movieGenre: MovieGenre.singleMovie),
                SizedBox(height: 16),
                HomeGenreTvShows(movieGenre: MovieGenre.tvShows),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() => Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                const SizedBox(width: 16),
                const LogoApp(),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.router.push(const SearchRoute());
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black54,
                            offset: Offset(0.5, 0.5),
                          ),
                        ],
                      ),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black54,
                            offset: Offset(0.5, 0.5),
                          ),
                        ],
                      ),
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      );
}

