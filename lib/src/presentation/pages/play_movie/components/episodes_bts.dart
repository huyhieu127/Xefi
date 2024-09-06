import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/presentation/widgets/toolbar_bts.dart';

class EpisodesBts extends StatefulWidget {
  final List<ServerEntity> servers;
  final EpisodeEntity? episodeCurrent;
  final Function(EpisodeEntity) onChangeEpisode;

  const EpisodesBts(
      {super.key,
      required this.servers,
      required this.episodeCurrent,
      required this.onChangeEpisode});

  @override
  State<EpisodesBts> createState() => _EpisodesBtsState();
}

class _EpisodesBtsState extends State<EpisodesBts> {
  List<EpisodeEntity> get _episodes =>
      (widget.servers.first.episodes ?? []).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.white12,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Column(
              children: [
                ToolbarBts(
                  title: "Danh sách tập",
                  onClose: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: DraggableScrollableSheet(
                    initialChildSize: 1.0,
                    minChildSize: 0.96,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      var height = 0.0;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final position = _episodes.indexWhere((entity) =>
                            entity.slug == widget.episodeCurrent?.slug);
                        final positionInGrid = position ~/ 4;
                        final heightInGrid = (height);
                        scrollController.jumpTo(heightInGrid * positionInGrid);
                      });
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        controller: scrollController,
                        shrinkWrap: true,
                        primary: false,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                          childAspectRatio: 2 / 1,
                        ),
                        itemCount: _episodes.length,
                        padding: const EdgeInsets.only(
                          bottom: 12,
                          left: 12,
                          right: 12,
                        ),
                        itemBuilder: (context, index) {
                          return LayoutBuilder(
                              builder: (context, boxConstraints) {
                            height = boxConstraints.maxHeight;
                            return _widgetItem(index: index);
                          });
                        },
                        //physics: NeverScrollableScrollPhysics(), // Ngăn không cho GridView cuộn bên ngoài
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetItem({required int index}) {
    final episode = _episodes[index];
    final isCurrent = widget.episodeCurrent?.slug == episode.slug;
    return GestureDetector(
      onTap: () {
        widget.onChangeEpisode(episode);
      },
      child: Card(
        elevation: 0,
        color: isCurrent ? ColorsHelper.navy : Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            "${episode.name}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
