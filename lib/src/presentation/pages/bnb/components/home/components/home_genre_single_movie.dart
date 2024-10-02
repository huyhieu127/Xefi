import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/presentation/cubit/home/get_single_movie/get_single_movie_cubit.dart';
import 'package:xefi/src/presentation/widgets/base_circular_prg.dart';
import 'package:xefi/src/presentation/widgets/item_movie_grid.dart';

class HomeGenreSingleMovie extends StatelessWidget {
  final MovieGenre movieGenre;

  const HomeGenreSingleMovie({super.key, required this.movieGenre});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _title(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigateToListMovie(context: context);
                  },
                  child: const Row(
                    children: [
                      Text(
                        "Xem hết",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<GetSingleMovieCubit, GetSingleMovieState>(
              builder: (context, state) {
                if (state is GetSingleMovieSuccess) {
                  final moviesGenreData = state.movieGenreDataEntity;
                  final moviesGenre = moviesGenreData?.movies ?? [];
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: moviesGenre.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = moviesGenre[index];
                      final domainLoadImage =
                          moviesGenreData?.appDomainCdnImage;
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
                          if ((item.slug ?? "").isNotEmpty) {
                            navigateToDetail(
                              context: context,
                              movieGenre: item,
                            );
                          }
                        },
                      );
                    },
                  );
                }
                return const Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    BaseCircularPrg(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _title() => "Phim lẻ";

  void navigateToListMovie({
    required BuildContext context,
  }) {
    context.router.push(
      ListMovieRoute(movieGenre: movieGenre, title: _title()),
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
