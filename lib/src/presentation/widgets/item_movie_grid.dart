import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xefi/gen/assets.gen.dart';
import 'package:xefi/src/core/helper/box_decoration.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/core/helper/shadow_helper.dart';
import 'package:xefi/src/core/utils/datetime_utils.dart';
import 'package:xefi/src/presentation/widgets/tag_right_corner.dart';

class ItemMovieGrid extends StatelessWidget {
  final String? posterUrl;
  final String? name;
  final String? originName;
  final int? year;
  final String? time;
  final String? episodeCurrent;
  final String? quality;
  final String? lang;
  final bool? isCinema;
  final String? modifiedTime;
  final GestureTapCallback? onTap;

  const ItemMovieGrid({
    super.key,
    this.posterUrl,
    this.name,
    this.originName,
    this.year,
    this.time,
    this.episodeCurrent,
    this.quality,
    this.lang,
    this.isCinema,
    this.modifiedTime,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: posterUrl ?? "",
                width: double.maxFinite,
                height: double.maxFinite,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecorationHelper.tagPrimary(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 7,
                      ),
                      child: Text(
                        "$episodeCurrent",
                        style: const TextStyle(
                          color: ColorsHelper.navy,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          DateTimeUtils.toTimeAgo(modifiedTime),
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            shadows: ShadowHelper.textShadow,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: Visibility(
                  visible: isCinema ?? false,
                  child: CustomPaint(
                    // Kích thước của khung chứa tam giác
                    painter: TagRightCorner(),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 8,
                        right: 8,
                        left: 32,
                        bottom: 32,
                      ),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            //colors: ColorsHelper.rainbows,
                            colors: [
                              ColorsHelper.black,
                              ColorsHelper.navy,
                              ColorsHelper.blue,
                            ],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.srcIn,
                        child: SvgPicture.asset(
                          Assets.svgs.icCinemaBold.path,
                          width: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        ColorsHelper.navy,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 100,
                    bottom: 8,
                    left: 8,
                    right: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "$name",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: ShadowHelper.textShadow,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$originName",
                        maxLines: 1,
                        style: TextStyle(
                          color: ColorsHelper.placeholder,
                          fontSize: 12,
                          shadows: ShadowHelper.textShadow,
                        ),
                        overflow: TextOverflow.ellipsis,
                        //textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$year',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              shadows: ShadowHelper.textShadow,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            //textAlign: TextAlign.center,
                          ),
                          Text(
                            '$time',
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            //textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        children: [
                          _tag(
                              name: lang ?? "",
                              textColor: Colors.white,
                              decoration: BoxDecorationHelper.tagRainbow()),
                          _tag(
                              name: quality ?? "",
                              textColor: Colors.white,
                              decoration: BoxDecorationHelper.tagRedPastel()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _tag({
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
}
