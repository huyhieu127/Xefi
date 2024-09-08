import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/video_player_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/injections_video_player.dart';
import 'package:xefi/src/presentation/widgets/video_player/frame_video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String thumbUrl;
  final EpisodeEntity episode;
  final List<ServerEntity> servers;
  final Function(EpisodeEntity) onChangeEpisode;

  const VideoPlayer({
    super.key,
    required this.thumbUrl,
    required this.episode,
    required this.servers,
    required this.onChangeEpisode,
  });

  void onUpdateEpisode({required EpisodeEntity episode}){
    injector<VideoPlayerCubit>().changeEpisode(episode: episode);
  }

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerCubit get _cubit => injector<VideoPlayerCubit>();
  final double _ratioMovie = 16 / 9;

  @override
  void initState() {
    registerVideoPlayerCubit();
    super.initState();
    _cubit.bindData(
      thumbUrl: widget.thumbUrl,
      episode: widget.episode,
      servers: widget.servers,
    );
    _intVideoController(_cubit.episode);
  }

  void _intVideoController(EpisodeEntity episodeCurrent) {
    _cubit.videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(_cubit.episode.linkM3u8 ?? ""));
    _cubit.videoPlayerController.initialize().then((_) {

      // Create chewie;
      _cubit.chewieController = ChewieController(
        videoPlayerController: _cubit.videoPlayerController,
        aspectRatio: _cubit.videoPlayerController.value.aspectRatio,
        autoInitialize: true,
        looping: false,
        autoPlay: false,
        showControls: false,
      );

      //Listener get duration
      _cubit.videoPlayerController.addListener(() {
        final buffered = _cubit.videoPlayerController.value.buffered;
        _cubit.durationControlCubit.updateDuration(
          position: _cubit.videoPlayerController.value.position,
          duration: _cubit.videoPlayerController.value.duration,
          buffered: buffered.isNotEmpty ? buffered.last.end : Duration.zero,
        );
      });

      _cubit.initialControllerCubit.videoControllerInitialized(episode: episodeCurrent);
    });
  }

  @override
  void dispose() {
    _cubit.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoPlayerCubit, VideoPlayerState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is VideoPlayerChangeEpisode) {
          var newEpisode = state.episode;
          widget.onChangeEpisode(newEpisode);
          _cubit.chewieController.pause();
          _cubit.videoPlayerController.pause();
          _intVideoController(newEpisode);
        }
      },
      child: AspectRatio(
        aspectRatio: _ratioMovie,
        child: Container(
          color: Colors.black,
          child: const FrameVideoPlayer(),
        ),
      ),
    );
  }
}
