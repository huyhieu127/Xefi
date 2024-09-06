import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xefi/src/core/helper/box_decoration.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/core/utils/extension_utils.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/entities/movie_detail/movie_detail_data_entity.dart';
import 'package:xefi/src/presentation/cubit/injector_play_movie_cubit.dart';
import 'package:xefi/src/presentation/cubit/play_movie/get_detail/get_detail_cubit.dart';
import 'package:xefi/src/presentation/cubit/play_movie/play_movie_cubit.dart';
import 'package:xefi/src/presentation/pages/play_movie/components/episodes_bts.dart';
import 'package:xefi/src/presentation/widgets/base_background.dart';
import 'package:xefi/src/presentation/widgets/button_back.dart';
import 'package:xefi/src/presentation/widgets/video_player/video_player.dart';

@RoutePage()
class PlayMoviePage extends StatefulWidget {
  final String slug;

  const PlayMoviePage({
    super.key,
    required this.slug,
  });

  @override
  State<PlayMoviePage> createState() => _PlayMoviePageState();
}

class _PlayMoviePageState extends State<PlayMoviePage> {

  @override
  void initState() {
    injectorPlayMovie.resetLazySingleton<PlayMovieCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injectorPlayMovie<PlayMovieCubit>(),
        ),
        BlocProvider(
          create: (context) => injectorPlayMovie<GetDetailCubit>()
            ..getDetail(slugName: widget.slug),
        ),
      ],
      child: BaseBackground(
        child: BlocBuilder<GetDetailCubit, GetDetailState>(
          builder: (context, state) {
            if (state is GetDetailSuccess) {
              final data = state.movieDetailData;
              return _containerPage(
                  data: data, thumbUrl: data?.movie?.thumbUrl ?? "");
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _containerPage({
    required MovieDetailDataEntity? data,
    required String thumbUrl,
  }) {
    final movie = data?.movie;
    final episode = data?.latestEpisode ?? const EpisodeEntity();
    final thumbUrl = movie?.thumbUrl ?? "";
    final servers = data?.servers ?? [];
    final heightMovie = context.screenSize().width * 9 / 16;

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: context.padding().top,
          left: 0,
          right: 0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: _widgetBackground(thumbUrl),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(top: context.padding().top),
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverAppBarDelegate(
                    height: heightMovie, // Set the fixed height here
                    child: MoviePlayer(
                      episode: episode,
                      thumbUrl: thumbUrl,
                      servers: servers,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _widgetInformation(movie: movie, servers: servers),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ButtonBack(
                onTap: () {
                  context.router.back();
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _widgetInformation({
    required MovieDetailEntity? movie,
    required List<ServerEntity> servers,
  }) {
    final episodeCurrent = servers.first.episodes?.last;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 48.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "${movie?.name}",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${movie?.originName}",
              style: const TextStyle(
                color: ColorsHelper.placeholder,
                //fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Card(
                      elevation: 20,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: CachedNetworkImage(
                          imageUrl: movie?.posterUrl ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              "Đang phát:    ",
                              style: TextStyle(
                                color: ColorsHelper.placeholder,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white12,
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 12),
                                  ),
                                  onPressed: () {
                                    final episodeCurrent =
                                        injectorPlayMovie<PlayMovieCubit>()
                                                .episodeCurrent ??
                                            servers.first.episodes?.lastOrNull;
                                    showEpisodes(
                                      servers: servers,
                                      episodeCurrent: episodeCurrent,
                                    );
                                  },
                                  child: BlocBuilder<PlayMovieCubit,
                                      PlayMovieState>(
                                    buildWhen: (p, c) =>
                                        c is PlayMovieInitial ||
                                        c is PlayMovieChangeEpisode,
                                    builder: (context, state) {
                                      String name = "";
                                      if (state is PlayMovieChangeEpisode) {
                                        name = state.episode.name ?? "";
                                      } else {
                                        name = episodeCurrent?.name ?? "";
                                      }
                                      return Row(
                                        children: [
                                          const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                            child: Text(
                                              name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Đã chiếu:   ",
                              style: TextStyle(
                                color: ColorsHelper.placeholder,
                              ),
                            ),
                            Text(
                              "${episodeCurrent?.name}${int.parse(movie?.episodeTotal ?? "0") > 1 ? " / ${movie?.episodeTotal}" : ""}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Thời lượng:   ",
                              style: TextStyle(
                                color: ColorsHelper.placeholder,
                              ),
                            ),
                            Text(
                              "${movie?.time}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Năm phát hành:   ",
                              style: TextStyle(
                                color: ColorsHelper.placeholder,
                              ),
                            ),
                            Text(
                              "${movie?.year}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Quốc gia:   ",
                              style: TextStyle(
                                color: ColorsHelper.placeholder,
                              ),
                            ),
                            Text(
                              "${movie?.country?.first.name}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Đạo diễn:   ",
                              style: TextStyle(
                                color: ColorsHelper.placeholder,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${movie?.director?.first}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Tình trạng:   ",
                              style: TextStyle(
                                color: ColorsHelper.placeholder,
                              ),
                            ),
                            _widgetTag(
                                name: movie?.lang ?? "",
                                textColor: Colors.white,
                                decoration: BoxDecorationHelper.tagRainbow()),
                            const SizedBox(width: 8),
                            _widgetTag(
                                name: movie?.quality ?? "",
                                textColor: Colors.white,
                                decoration: BoxDecorationHelper.tagRedPastel()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Diễn viên tham gia:",
              style: TextStyle(
                color: ColorsHelper.placeholder,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              children: List.generate(
                movie?.actor?.length ?? 0,
                (index) {
                  final item = movie!.actor?[index];
                  return _widgetCardName(name: item ?? "");
                },
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Thể loại:",
              style: TextStyle(
                color: ColorsHelper.placeholder,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              children: List.generate(
                movie?.category?.length ?? 0,
                (index) {
                  final item = movie!.category?[index];
                  return _widgetCardName(name: item?.name ?? "");
                },
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Nội dung film:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              movie?.content ?? "",
              style: const TextStyle(
                color: ColorsHelper.placeholder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetBackground(String thumbUrl) {
    if (thumbUrl.isEmpty) {
      return const SizedBox();
    }
    return Stack(
      children: [
        Positioned.fill(
          top: context.padding().top / 2,
          child: CachedNetworkImage(
            imageUrl: thumbUrl,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 100, sigmaY: 100, tileMode: TileMode.clamp),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(),
          ),
        ),
      ],
    );
  }

  Widget _widgetCardName({required String name}) {
    return SizedBox(
      child: Card(
        elevation: 10,
        color: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetTag({
    required String name,
    required Color textColor,
    required Decoration decoration,
  }) {
    return Container(
      decoration: decoration,
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 7,
      ),
      child: Text(
        name,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void showEpisodes({
    required List<ServerEntity> servers,
    required EpisodeEntity? episodeCurrent,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 10,
      builder: (BuildContext context) {
        return EpisodesBts(
          servers: servers,
          episodeCurrent: episodeCurrent,
          onChangeEpisode: (episode) {
            changeEpisode(episode: episode);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void changeEpisode({required EpisodeEntity episode}) {
    injectorPlayMovie<PlayMovieCubit>().changeEpisode(episode: episode);
  }
}

class MySliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  MySliverAppBarDelegate({
    required this.height,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Return the child with the fixed size
    return SizedBox(
      height: height,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // Cast oldDelegate to MySliverAppBarDelegate to compare values
    if (oldDelegate is MySliverAppBarDelegate) {
      return oldDelegate.height != height || oldDelegate.child != child;
    }
    return true; // Rebuild if the delegate is of a different type
  }
}
