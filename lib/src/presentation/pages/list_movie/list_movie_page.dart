import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/cubit/list_movie/list_movie_cubit.dart';
import 'package:xefi/src/presentation/widgets/base_appbar.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/base_circular_prg.dart';
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

  final cubit = injector<ListMovieCubit>();

  late final ScrollController _controller = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
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
      cubit.getListMovie(movieGenre: widget.movieGenre);
    }
  }

  Future<void> _onRefresh() async {
    _isLoading = true;
    cubit.getListMovie(movieGenre: widget.movieGenre, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getListMovie(movieGenre: widget.movieGenre),
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
            final canLoadMore = !(cubit.hasReachedMax);
            if (state is ListMovieSuccess) {
              final movies = state.movies;
              final domainLoadImage = state.domainImage;
              return CustomScrollView(
                controller: _controller,
                slivers: [
                  const SliverAppBar(
                    backgroundColor: Colors.transparent,
                    toolbarHeight: 0,
                  ),
                  CupertinoSliverRefreshControl(
                    onRefresh: _onRefresh,
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid.builder(
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
                      )),
                  SliverToBoxAdapter(
                    child: SafeArea(
                      top: false,
                      child: canLoadMore
                          ? Container(
                              padding: const EdgeInsets.all(24),
                              alignment: Alignment.center,
                              height: 200,
                              child: const BaseCircularPrg(),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: BaseCircularPrg(),
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
