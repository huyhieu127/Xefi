import 'dart:async';
import 'dart:core';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/core/utils/extension_utils.dart';
import 'package:xefi/src/core/utils/screen_utils.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/presentation/widgets/video_player/video_control_gestures.dart';
import 'package:xefi/src/presentation/widgets/video_player/video_player_fullscreen.dart';

class VideoControls extends StatefulWidget {
  VideoControls({
    super.key,
  });

  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;
  bool isBindController = false;
  late String thumbUrl;
  late EpisodeEntity episode;
  late List<ServerEntity> servers;
  late Function(EpisodeEntity) onChangeEpisode;

  void bindUI({
    required VideoPlayerController videoPlayerController,
    required ChewieController chewieController,
    required String thumbUrl,
    required EpisodeEntity episode,
    required List<ServerEntity> servers,
    required Function(EpisodeEntity) onChangeEpisode,
  }) {
    this.videoPlayerController = videoPlayerController;
    this.chewieController = chewieController;
    isBindController = true;
    this.thumbUrl = thumbUrl;
    this.episode = episode;
    this.servers = servers;
    this.onChangeEpisode = onChangeEpisode;
  }

  @override
  State<VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls>
    implements VideoControlGestures {
  VideoPlayerController get _videoPlayerController =>
      widget.videoPlayerController;

  ChewieController get _chewieController => widget.chewieController;

  get _isBindController => widget.isBindController;

  bool get _isPortrait => context.orientation() == Orientation.portrait;

  final StreamController<bool> _streamHideThumbnail = StreamController<bool>();
  final StreamController<bool> _streamPlayStatus = StreamController<bool>();
  final StreamController<double> _streamVisibleControls =
      StreamController<double>();
  bool isVisibleControls = false;

  Timer? _timer;
  final ValueNotifier<Duration?> _positionNotifier =
      ValueNotifier<Duration?>(null);
  final Duration _skipValue = const Duration(seconds: 5);

  final ScrollController _scrollEpisodesController = ScrollController();
  FrameCallback? _frameCallback;
  final ValueNotifier<bool> _showEpisodesNotifier = ValueNotifier(false);
  late ValueNotifier<EpisodeEntity> _episodesNotifier;

  final List<double> speeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
  final ValueNotifier<bool> _showSpeedNotifier = ValueNotifier(false);
  final ValueNotifier<double> _speedNotifier = ValueNotifier(1);

  late bool _isPlayingWhenOpen;

  @override
  void initState() {
    _isPlayingWhenOpen = _chewieController.isPlaying; //Need for to landscape
    super.initState();
    _episodesNotifier = ValueNotifier(widget.episode);
    _videoPlayerController.addListener(() {
      _positionNotifier.value = _videoPlayerController.value.position;
    });
  }

  @override
  void dispose() {
    _streamHideThumbnail.close();
    _streamPlayStatus.close();
    _streamVisibleControls.close();
    updateWakelockPlus(enable: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isBindController) {
      return const SizedBox();
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: StreamBuilder<bool>(
        stream: _streamHideThumbnail.stream,
        builder: (context, snapshot) {
          var isHideThumbnail = (snapshot.data ?? false) || !_isPortrait;
          return Stack(
            children: [
              Positioned.fill(
                child: _widgetThumbnail(isHideThumbnail: isHideThumbnail),
              ),
              Positioned.fill(
                child: _widgetControls(isHideThumbnail: isHideThumbnail),
              ),
              Positioned.fill(
                right: null,
                child: _widgetEpisodes(servers: widget.servers),
              ),
              Positioned.fill(
                left: null,
                child: _widgetSpeeds(speeds: speeds),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Widgets
  Widget _widgetThumbnail({required bool isHideThumbnail}) {
    return Visibility(
      visible: !isHideThumbnail,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: widget.thumbUrl,
            fit: BoxFit.cover,
            memCacheHeight: 400,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(36),
              ),
              height: 72,
              width: 72,
              child: IconButton(
                onPressed: () {
                  togglePlay();
                },
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetControls({required bool isHideThumbnail}) {
    return IgnorePointer(
      ignoring: !isHideThumbnail,
      child: StreamBuilder<double>(
          stream: _streamVisibleControls.stream,
          builder: (context, snapshot) {
            var opacity = snapshot.data ?? 0.0;
            isVisibleControls = opacity == 1.0;
            return AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 500),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _widgetControlsCenter(),
                  ),
                  Positioned.fill(
                    bottom: null,
                    child: _widgetControlsTop(),
                  ),
                  Positioned.fill(
                    top: null,
                    child: _widgetControlsBottom(),
                  ),
                  Positioned.fill(
                    child: Visibility(
                      visible: opacity == 0.0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          tapToVideo();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _widgetControlsTop() {
    return Visibility(
      visible: !_isPortrait,
      child: Container(
        color: Colors.black54,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  tapShowEpisodes();
                },
                icon: const Icon(
                  Icons.list_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${widget.episode.name}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  tapShowSpeed();
                },
                icon: const Icon(
                  Icons.speed_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetControlsCenter() {
    return GestureDetector(
      onTap: () {
        tapToBackgroundCenterControls();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(26),
              ),
              height: 52,
              width: 52,
              child: IconButton(
                onPressed: () {
                  rewind();
                },
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 60),
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(36),
              ),
              height: 72,
              width: 72,
              child: IconButton(
                onPressed: () {
                  togglePlay();
                },
                icon: StreamBuilder<bool>(
                    stream: _streamPlayStatus.stream,
                    builder: (context, snapshot) {
                      var isPlay = snapshot.data ?? _isPlayingWhenOpen;
                      return Icon(
                        isPlay ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 40,
                      );
                    }),
              ),
            ),
            const SizedBox(width: 60),
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(26),
              ),
              height: 52,
              width: 52,
              child: IconButton(
                onPressed: () {
                  forward();
                },
                icon: const Icon(
                  Icons.skip_next_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetControlsBottom() {
    return Container(
      color: Colors.black54,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 8),
                ValueListenableBuilder(
                  valueListenable: _positionNotifier,
                  builder: (BuildContext context, value, Widget? child) {
                    final position =
                        value ?? _videoPlayerController.value.position;
                    final duration = _videoPlayerController.value.duration;
                    return _widgetTimestamp(
                      position: position,
                      duration: duration,
                    );
                  },
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    changeOrientation();
                  },
                  icon: Icon(
                    _isPortrait
                        ? Icons.fullscreen_rounded
                        : Icons.fullscreen_exit_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              height: 4,
              color: ColorsHelper.blue,
            )
          ],
        ),
      ),
    );
  }

  Widget _widgetTimestamp({Duration? position, required Duration duration}) {
    final textPosition = formatDuration(duration: position);
    final textDuration = formatDuration(duration: duration);
    return Text(
      "$textPosition / $textDuration",
      style: const TextStyle(
        color: Colors.white,
      ),
      textWidthBasis: TextWidthBasis.parent,
    );
  }

  Widget _widgetEpisodes({required List<ServerEntity> servers}) {
    final episodes = servers.first.episodes?.reversed.toList() ?? [];
    return ValueListenableBuilder<bool>(
      valueListenable: _showEpisodesNotifier,
      builder: (context, value, widget) {
        const height = 50.0;
        if (value && _frameCallback == null) {
          _frameCallback = (callback) {
            var isShow = _showEpisodesNotifier.value;
            if (isShow) {
              final episodes =
                  this.widget.servers.first.episodes?.reversed.toList() ?? [];
              final double position = episodes
                  .indexWhere(
                      (entity) => entity.slug == this.widget.episode.slug)
                  .toDouble();
              _scrollEpisodesController.jumpTo(position * height);
            }
          };
          WidgetsBinding.instance.addPostFrameCallback(_frameCallback!);
        }

        return Visibility(
          visible: value,
          child: Container(
            color: Colors.black87,
            width: 300,
            child: SafeArea(
              right: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    height: height,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Danh sách tập",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            tapCloseEpisodes();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollEpisodesController,
                      itemBuilder: (context, index) {
                        final episode = episodes[index];
                        final slug = episode.slug;
                        return ValueListenableBuilder(
                          valueListenable: _episodesNotifier,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            final isSelected = slug == value.slug;
                            return GestureDetector(
                              onTap: () {
                                setEpisode(episode: episode);
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: height,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: isSelected == false
                                    ? null
                                    : BoxDecoration(
                                        border: Border.all(
                                          color: ColorsHelper.blue,
                                        ),
                                      ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    episode.name ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      itemCount: episodes.length,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _widgetSpeeds({required List<double> speeds}) {
    return ValueListenableBuilder<bool>(
      valueListenable: _showSpeedNotifier,
      builder: (context, value, widget) {
        return Visibility(
          visible: value,
          child: Container(
            color: Colors.black87,
            width: 250,
            child: SafeArea(
              left: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Tốc độ phát",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            tapCloseSpeed();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 2,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final speed = speeds[index];
                          return ValueListenableBuilder(
                              valueListenable: _speedNotifier,
                              builder: (context, value, widget) {
                                final isSelected = speed == value;
                                return GestureDetector(
                                  onTap: () {
                                    setSpeed(speed: speed);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    decoration: isSelected == false
                                        ? null
                                        : BoxDecoration(
                                            border: Border.all(
                                              color: ColorsHelper.blue,
                                            ),
                                          ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      speed == 1 ? "Bình thường" : "x$speed ",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        itemCount: speeds.length,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void changeOrientation() async {
    if (_isPortrait) {
      final result = await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              VideoPlayerFullscreen(
            videoPlayerController: _videoPlayerController,
            chewieController: _chewieController,
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
      if (!context.mounted) return;
      updatePlayState(isPlaying: result); //Need when back to portrait
    } else {
      Navigator.pop(context, _chewieController.isPlaying);
    }
  }

  @override
  void togglePlay() {
    _streamHideThumbnail.add(true);
    showControls();
    if (_chewieController.isPlaying) {
      updateWakelockPlus(enable: false);
      updatePlayState(isPlaying: false);
      _chewieController.pause();
    } else {
      updateWakelockPlus(enable: true);
      updatePlayState(isPlaying: true);
      _chewieController.play();
    }
  }

  @override
  void setEpisode({required EpisodeEntity episode}) {
    _episodesNotifier.value = episode;
    widget.onChangeEpisode(episode);
    changeOrientation();
  }

  @override
  void tapShowEpisodes() {
    _showEpisodesNotifier.value = true;
  }

  @override
  void tapCloseEpisodes() {
    _showEpisodesNotifier.value = false;
  }

  @override
  void setSpeed({required double speed}) {
    _videoPlayerController.setPlaybackSpeed(speed);
    _speedNotifier.value = speed;
  }

  @override
  void tapShowSpeed() {
    _showSpeedNotifier.value = true;
  }

  @override
  void tapCloseSpeed() {
    _showSpeedNotifier.value = false;
  }

  @override
  void forward() {
    showControls();
    final duration = _videoPlayerController.value.duration.inSeconds;
    final current = _videoPlayerController.value.position.inSeconds;
    var fastForwardValue = current + _skipValue.inSeconds;
    if (fastForwardValue > duration) {
      fastForwardValue = duration;
    }
    final newPosition = Duration(seconds: fastForwardValue);
    _chewieController.seekTo(newPosition);
  }

  @override
  void rewind() {
    showControls();
    final current = _videoPlayerController.value.position.inSeconds;
    var rewindValue = current - _skipValue.inSeconds;
    if (rewindValue < 0) {
      rewindValue = 0;
    }
    final newPosition = Duration(seconds: rewindValue);
    _chewieController.seekTo(newPosition);
  }

  @override
  void tapToVideo() {
    if (!_isPortrait) {
      hideSystemBars();
    }
    showControls();
  }

  @override
  void tapToBackgroundCenterControls() {
    if (!_isPortrait) {
      hideSystemBars();
    }
    hideControlsImmediately();
  }

  /// Methods
  void showControls() {
    if (!_streamVisibleControls.isClosed) {
      _streamVisibleControls.add(1.0); // Hiện lại widget khi có tương tác
      _timer?.cancel(); // Hủy bỏ timer hiện tại nếu có
      _timer = Timer(const Duration(seconds: 2), () {
        if (!_streamVisibleControls.isClosed) {
          if (!_isPortrait) {
            hideSystemBars();
          }
          _streamVisibleControls.add(0.0); // Bắt đầu fade out sau 5 giây
        }
      });
    }
  }

  void hideControlsImmediately() {
    _timer?.cancel();
    if (!_streamVisibleControls.isClosed) {
      _streamVisibleControls.add(0.0);
    }
  }

  void updatePlayState({required bool isPlaying}) {
    _streamPlayStatus.add(isPlaying);
  }

  Future<void> updateWakelockPlus({required bool enable}) async {
    if (enable) {
      if (!(await WakelockPlus.enabled)) {
        await WakelockPlus.enable();
      }
    } else {
      if (await WakelockPlus.enabled) {
        await WakelockPlus.disable();
      }
    }
  }
}

String formatDuration({required Duration? duration}) {
  if (duration == null) {
    return "00:00";
  }
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return duration.inHours > 0
      ? "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds"
      : "$twoDigitMinutes:$twoDigitSeconds";
}
