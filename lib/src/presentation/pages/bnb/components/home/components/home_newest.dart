import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xefi/src/config/router/app_router.gr.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/core/helper/gradient_helper.dart';
import 'package:xefi/src/core/helper/shadow_helper.dart';
import 'package:xefi/src/core/utils/datetime_utils.dart';
import 'package:xefi/src/core/utils/extension_utils.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/presentation/cubit/home/get_newest/get_newest_cubit.dart';
import 'package:xefi/src/presentation/cubit/home/home_cubit.dart';
import 'package:xefi/src/presentation/widgets/base_circular_prg.dart';
import 'package:xefi/src/presentation/widgets/base_indicator.dart';

class HomeNewest extends StatefulWidget {
  const HomeNewest({super.key});

  @override
  State<HomeNewest> createState() => _HomeNewestState();
}

class _HomeNewestState extends State<HomeNewest> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentPageIndex = 0;
  int _oldPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenSize().width,
      child: BlocBuilder<GetNewestCubit, GetNewestState>(
        builder: (context, state) {
          if (state is GetNewestSuccess) {
            var list = state.newestList;
            if (list.isNotEmpty) {
              context.read<HomeCubit>().setCurrentPageIndex(
                    size: list.length,
                    currentIndex: _currentPageIndex,
                    oldIndex: _oldPageIndex,
                    offset: 0,
                  );
            }
            return Stack(
              children: [
                Positioned.fill(
                  child: _imageBg(list),
                ),
                Positioned(child: _blurImageBg(list)),
                Positioned.fill(
                  child: _pager(list),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _footer(list),
                ),
              ],
            );
          }
          return const Align(
            child: BaseCircularPrg(),
          );
        },
      ),
    );
  }

  _imageBg(List<MovieNewestEntity> list) {
    final cacheWidth = context.screenSize().width.toInt();
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (p, c) {
        if (c is HomePagerIndicator && p is HomePagerIndicator) {
          return c.currentIndex != p.currentIndex;
        } else if (c is HomePagerIndicator) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is HomePagerIndicator) {
          var item = list[state.currentIndex];
          return CachedNetworkImage(
            imageUrl: item.thumbUrl ?? "",
            fit: BoxFit.contain,
            memCacheHeight: cacheWidth,
            fadeInCurve: Curves.easeIn,
            fadeInDuration: const Duration(milliseconds: 500),
            fadeOutCurve: Curves.easeOut,
            fadeOutDuration: const Duration(milliseconds: 500),

          );
        }
        return const SizedBox();
      },
    );
  }

  _blurImageBg(List<MovieNewestEntity> list) {
    return IgnorePointer(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 100, sigmaY: 100, tileMode: TileMode.clamp),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
        ),
      ),
    );
  }

  _pager(List<MovieNewestEntity> list) {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 1,
        autoPlayInterval: const Duration(seconds: 10),
        viewportFraction: 1,
        clipBehavior: Clip.none,
        onPageChanged: (index, reason) {
          _oldPageIndex = _currentPageIndex;
          _currentPageIndex = index;
        },
        onScrolled: (offset) {
          if (offset != null) {
            context.read<HomeCubit>().setCurrentPageIndex(
                  size: list.length,
                  currentIndex: _currentPageIndex,
                  oldIndex: _oldPageIndex,
                  offset: offset - offset.toInt(),
                );
          }
        },
      ),
      itemCount: list.length,
      itemBuilder: (context, itemIndex, pageViewIndex) {
        var item = list[itemIndex];
        final cacheWidth = context.screenSize().width.toInt();
        return ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.white12,
                Colors.white,
                Colors.white24,
                Colors.transparent,
              ],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: CachedNetworkImage(
            imageUrl: item.thumbUrl ?? "",
            memCacheHeight: cacheWidth,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  _footer(List<MovieNewestEntity> list) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (p, c) {
          if (c is HomePagerIndicator && p is HomePagerIndicator) {
            return c.currentIndex != p.currentIndex;
          } else if (c is HomePagerIndicator) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is HomePagerIndicator) {
            var item = list[state.currentIndex];
            return _contentFooter(item);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _contentFooter(MovieNewestEntity item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IgnorePointer(
          child: Text(
            item.name ?? "",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              shadows: ShadowHelper.textShadow,
            ),
          ),
        ),
        const SizedBox(height: 4),
        IgnorePointer(
          child: Text(
            item.originName ?? "",
            style: TextStyle(
              color: ColorsHelper.placeholder,
              shadows: ShadowHelper.textShadow,
            ),
          ),
        ),
        const SizedBox(height: 4),
        IgnorePointer(
          child: Text(
            "Năm phát hành: ${item.year}",
            style: TextStyle(
              color: Colors.white,
              shadows: ShadowHelper.textShadow,
            ),
          ),
        ),
        const SizedBox(height: 8),
        IgnorePointer(
          child: Row(
            children: [
              Icon(
                Icons.access_time,
                color: Colors.white,
                size: 16,
                shadows: ShadowHelper.textShadow,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                DateTimeUtils.toTimeAgo(item.modified?.time),
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black87,
                      offset: Offset(0.5, 0.5),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
              gradient: GradientHelper.primary(),
              borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              if ((item.slug ?? "").isNotEmpty) {
                context.router.push(
                  PlayMovieRoute(slug: item.slug!),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.play_circle_outline_rounded,
                    color: ColorsHelper.navy,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Xem ngay",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorsHelper.navy),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (p, c) => c is HomePagerIndicator && p != c,
          builder: (context, state) {
            if (state is HomePagerIndicator) {
              var itemCount = state.itemCount;
              var currentIndex = state.currentIndex;
              var oldIndex = state.oldIndex;
              return BaseIndicator(
                itemCount: itemCount,
                currentIndex: currentIndex,
                oldIndex: oldIndex,
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  bool _isLightColor(Color color) {
    var grayscale =
        (0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue);
    return grayscale > 128;
  }
}
