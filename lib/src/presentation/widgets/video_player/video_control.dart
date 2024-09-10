import 'dart:async';
import 'dart:core';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';
import 'package:xefi/src/core/utils/screen_utils.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/duration_control/duration_control_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/initialized_controller/initial_controller_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/play_control/play_control_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/video_player_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibilitity_thumbnail/visibility_thumbnail_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibility_controls/visibility_controls_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibility_episodes/visibility_episodes_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibility_speeds/visibility_speeds_cubit.dart';
import 'package:xefi/src/presentation/widgets/video_player/frame_video_player.dart';
import 'package:xefi/src/presentation/widgets/video_player/video_control_gestures.dart';

class VideoControls extends StatefulWidget {
  const VideoControls({super.key});

  @override
  State<VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls>
    implements VideoControlGestures {
  VideoPlayerCubit get _cubit => injector<VideoPlayerCubit>();

  VideoPlayerController get _videoPlayerController =>
      _cubit.videoPlayerController;

  ChewieController get _chewieController => _cubit.chewieController;

  String get _thumbUrl => _cubit.thumbUrl;

  EpisodeEntity get _episode => _cubit.episode;

  List<ServerEntity> get _servers => _cubit.servers;

  bool get _isPortrait => _cubit.isPortrait;

  Timer? _timer;

  final Duration _skipValue = const Duration(seconds: 5);

  final ScrollController _scrollEpisodesController = ScrollController();
  FrameCallback? _frameCallback;

  final List<double> speeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  @override
  void dispose() {
    updateWakelockPlus(enable: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: MultiBlocListener(
        listeners: [
          BlocListener<InitialControllerCubit, InitializedControllerState>(
            bloc: _cubit.initialControllerCubit,
            listener: (context, state) {
              if (state is ControllerInitialized) {
                _cubit.visibilityThumbnailCubit
                    .setVisibilityThumbnail(isVisible: true);
              }
            },
          ),
        ],
        child: Stack(
          children: [
            Positioned.fill(
              child: _widgetControls(),
            ),
            Positioned.fill(
              child: _widgetThumbnail(),
            ),
            Positioned.fill(
              right: null,
              child: _widgetEpisodes(),
            ),
            Positioned.fill(
              left: null,
              child: _widgetSpeeds(speeds: speeds),
            ),
          ],
        ),
      ),
    );
  }

  /// Widgets
  Widget _widgetThumbnail() {
    return BlocBuilder<VisibilityThumbnailCubit, VisibilityThumbnailState>(
      bloc: _cubit.visibilityThumbnailCubit,
      builder: (context, state) {
        var isVisible = state is VisibilityThumbnail ? state.isVisible : true;
        return Visibility(
          visible: isVisible,
          child: Stack(
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: _thumbUrl,
                  fit: BoxFit.cover,
                  memCacheHeight: 400,
                ),
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
      },
    );
  }

  Widget _widgetControls() {
    return BlocBuilder<VisibilityControlsCubit, VisibilityControlsState>(
        bloc: _cubit.visibilityControlsCubit,
        builder: (context, state) {
          final isVisible =
              state is VisibilityControls ? state.isVisible : false;
          var opacity = isVisible ? 1.0 : 0.0;
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
        });
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
                "${_episode.name}",
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
                icon: BlocBuilder<PlayControlCubit, PlayControlState>(
                  bloc: _cubit.playControlCubit,
                  builder: (context, state) {
                    var isPlay = state is PlayControl && state.isPlaying;
                    return Icon(
                      isPlay ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 40,
                    );
                  },
                ),
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
                BlocBuilder(
                  bloc: _cubit.durationControlCubit,
                  builder: (context, state) {
                    var position = _videoPlayerController.value.position;
                    var duration = _videoPlayerController.value.duration;

                    final buffered = _videoPlayerController.value.buffered;
                    var bufferedDuration =
                        buffered.isNotEmpty ? buffered.last.end : Duration.zero;
                    if (state is DurationControl) {
                      position = state.position;
                      duration = state.duration;
                      bufferedDuration = state.buffered;
                      checkEnd(position: position, duration: duration);
                    }
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

  Widget _widgetEpisodes() {
    final episodes = _servers.first.episodes?.reversed.toList() ?? [];
    return BlocBuilder<VisibilityEpisodesCubit, VisibilityEpisodesState>(
      bloc: _cubit.visibilityEpisodesCubit,
      builder: (context, state) {
        const height = 50.0;
        var isVisible = !_cubit.isPortrait &&
            state is VisibilityEpisodesControl &&
            state.isVisible;
        if (isVisible && _frameCallback == null) {
          _frameCallback = (callback) {
            if (isVisible) {
              final episodes = _servers.first.episodes?.reversed.toList() ?? [];
              final double position = episodes
                  .indexWhere((entity) => entity.slug == _episode.slug)
                  .toDouble();
              _scrollEpisodesController.jumpTo(position * height);
            }
          };
          WidgetsBinding.instance.addPostFrameCallback(_frameCallback!);
        }
        return Visibility(
          visible: isVisible,
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
                        return BlocBuilder(
                          bloc: _cubit,
                          builder: (context, state) {
                            var slugCurrent = state is VideoPlayerChangeEpisode
                                ? state.episode.slug
                                : _cubit.episode.slug;
                            final isSelected = slug == slugCurrent;
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
    return BlocBuilder<VisibilitySpeedsCubit, VisibilitySpeedsState>(
      bloc: _cubit.visibilitySpeedsCubit,
      builder: (context, state) {
        var isVisible = !_cubit.isPortrait &&
            state is VisibilitySpeedsControl &&
            state.isVisible;
        return Visibility(
          visible: isVisible,
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
                          return BlocBuilder(
                              bloc: _cubit,
                              builder: (context, state) {
                                var currentSpeed =
                                    state is VideoPlayerChangeSpeed
                                        ? state.speed
                                        : _cubit.speed;
                                final isSelected = speed == currentSpeed;
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
    if (_cubit.isPortrait) {
      _cubit.isPortrait = false;
      await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              _VideoPlayerFullscreen(
            tapBackWhenInitialVideoController: () {
              changeOrientation();
            },
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else {
      _cubit.isPortrait = true;
      _cubit.visibilityEpisodesCubit
          .setVisibilityEpisodesControl(isVisible: false);
      _cubit.visibilitySpeedsCubit.setVisibilitySpeedsControl(isVisible: false);
      hideControlsImmediately();
      Navigator.pop(context, _chewieController.isPlaying);
    }
  }

  @override
  void togglePlay() {
    _cubit.visibilityThumbnailCubit.setVisibilityThumbnail(isVisible: false);
    if (_chewieController.isPlaying) {
      showControls();
      updateWakelockPlus(enable: false);
      _cubit.playControlCubit.setPlay(isPlay: false);
      _chewieController.pause();
    } else {
      hideControlsImmediately();
      updateWakelockPlus(enable: true);
      _cubit.playControlCubit.setPlay(isPlay: true);
      _chewieController.play();
    }
  }

  void checkEnd({required Duration position, required Duration duration}) {
    if(position == duration){
      if (!_cubit.isEnd) {
        _cubit.isEnd = true;
        updateWakelockPlus(enable: false);
        _cubit.playControlCubit.setPlay(isPlay: false);
      }
    }else{
      _cubit.isEnd = false;
    }
  }

  @override
  void setEpisode({required EpisodeEntity episode}) {
    _cubit.changeEpisode(episode: episode);
    //changeOrientation();
  }

  @override
  void tapShowEpisodes() {
    _cubit.visibilityEpisodesCubit
        .setVisibilityEpisodesControl(isVisible: true);
  }

  @override
  void tapCloseEpisodes() {
    _cubit.visibilityEpisodesCubit
        .setVisibilityEpisodesControl(isVisible: false);
  }

  @override
  void setSpeed({required double speed}) {
    _videoPlayerController.setPlaybackSpeed(speed);
    _cubit.changeSpeed(speed: speed);
  }

  @override
  void tapShowSpeed() {
    _cubit.visibilitySpeedsCubit.setVisibilitySpeedsControl(isVisible: true);
  }

  @override
  void tapCloseSpeed() {
    _cubit.visibilitySpeedsCubit.setVisibilitySpeedsControl(isVisible: false);
  }

  @override
  void forward() {
    showControls();
    final duration = _videoPlayerController.value.duration.inSeconds;
    final current = _videoPlayerController.value.position.inSeconds;
    var fastForwardValue = current + _skipValue.inSeconds;
    if (fastForwardValue >= duration) {
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
    hideControlsImmediately();
  }

  /// Methods
  void showControls({
    bool isAutoHide = true,
  }) {
    _cubit.visibilityControlsCubit.setVisibilityControls(
        isVisible: true); // Hiện lại widget khi có tương tác
    _timer?.cancel(); // Hủy bỏ timer hiện tại nếu có
    if (isAutoHide) {
      _timer = Timer(const Duration(seconds: 2), () {
        if (!_isPortrait) {
          hideSystemBars();
        }
        _cubit.visibilityControlsCubit.setVisibilityControls(isVisible: false);
      });
    }
  }

  void hideControlsImmediately() {
    _timer?.cancel();
    if (!_isPortrait) {
      hideSystemBars();
    }
    _cubit.visibilityControlsCubit.setVisibilityControls(isVisible: false);
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

class _VideoPlayerFullscreen extends StatefulWidget {
  final VoidCallback tapBackWhenInitialVideoController;

  const _VideoPlayerFullscreen(
      {required this.tapBackWhenInitialVideoController});

  @override
  State<_VideoPlayerFullscreen> createState() => _VideoPlayerFullscreenState();
}

class _VideoPlayerFullscreenState extends State<_VideoPlayerFullscreen> {
  VideoPlayerCubit get _cubit => injector<VideoPlayerCubit>();

  @override
  void initState() {
    super.initState();
    enterFullScreen();
  }

  @override
  void dispose() {
    exitFullScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: FrameVideoPlayer(
        tapBackWhenInitialVideoController: () {
          widget.tapBackWhenInitialVideoController();
        },
      ),
    );
  }
}
