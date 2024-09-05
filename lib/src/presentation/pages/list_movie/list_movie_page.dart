import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/presentation/cubit/injector_home_cubit.dart';
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
            if (state is ListMovieSuccess) {
              final moviesGenreData = state.movieGenreDataEntity;
              final movies = moviesGenreData?.movies ?? [];

              final domainLoadImage = moviesGenreData?.appDomainCdnImage;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: movies.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        navigateToDetail(context: context, movieGenre: item);
                      },
                    );
                  },
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
