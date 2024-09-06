import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/presentation/cubit/injector_home_cubit.dart';
import 'package:xefi/src/presentation/cubit/injector_list_movie_cubit.dart';
import 'package:xefi/src/presentation/cubit/list_movie/list_movie_cubit.dart';
import 'package:xefi/src/presentation/widgets/base_appbar.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/button_back.dart';
import 'package:xefi/src/presentation/widgets/item_movie_grid.dart';

@RoutePage()
class ListMoviePage extends StatefulWidget {
  final MovieGenre movieGenre;
  final String title;

  const ListMoviePage(
      {super.key, required this.movieGenre, required this.title});

  @override
  State<ListMoviePage> createState() => _ListMoviePageState();
}

class _ListMoviePageState extends State<ListMoviePage> {
  static const double _endReachedThreshold = 200;

  late final ScrollController _controller = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    injectorListMovie.resetLazySingleton<ListMovieCubit>();
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (!_controller.hasClients || _isLoading) return;
    final thresholdReached =
        _controller.position.extentAfter < _endReachedThreshold;
    if (thresholdReached) {
      _isLoading = true;
      injectorHome<ListMovieCubit>()
          .getListMovie(movieGenre: widget.movieGenre);
    }
  }

  Future<void> _onRefresh() async {
    _isLoading = true;
    injectorHome<ListMovieCubit>()
        .getListMovie(movieGenre: widget.movieGenre, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injectorHome<ListMovieCubit>()
        ..getListMovie(movieGenre: widget.movieGenre),
      child: BaseBackground(
        baseAppBar: BaseAppbar(
          child: SafeArea(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ButtonBack(
                    onTap: () {
                      context.router.back();
                    },
                  ),
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        child: BlocBuilder<ListMovieCubit, ListMovieState>(
          builder: (context, state) {
            _isLoading = false;
            final canLoadMore =
                !(injectorListMovie<ListMovieCubit>().hasReachedMax);
            if (state is ListMovieSuccess) {
              final movies = state.movies;
              final domainLoadImage = state.domainImage;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomScrollView(
                  controller: _controller,
                  slivers: [
                    const SliverAppBar(
                      backgroundColor: Colors.transparent,
                      toolbarHeight: 0,
                    ),
                    CupertinoSliverRefreshControl(
                      onRefresh: _onRefresh,
                    ),
                    SliverGrid.builder(
                      itemCount: movies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final item = movies[index];
                        return ItemMovieGrid(
                          posterUrl: '$domainLoadImage/${item.posterUrl}',
                          name: item.name,
                          originName: item.originName,
                          year: item.year,
                          time: item.time,
                          episodeCurrent: item.episodeCurrent,
                          quality: item.quality,
                          lang: item.lang,
                          isCinema: item.chieuRap,
                          modifiedTime: item.modified?.time,
                          onTap: () {
                            navigateToDetail(
                                context: context, movieGenre: item);
                          },
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: canLoadMore
                          ? Container(
                              padding: const EdgeInsets.all(24),
                              alignment: Alignment.center,
                              height: 200,
                              child: const CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateToDetail({
    required BuildContext context,
    required MovieGenreEntity movieGenre,
  }) {
    if ((movieGenre.slug ?? "").isNotEmpty) {
      context.router.push(
        PlayMovieRoute(slug: movieGenre.slug!),
      );
    }
  }
}
