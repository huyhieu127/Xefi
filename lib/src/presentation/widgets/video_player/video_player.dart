import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/presentation/cubit/play_movie/play_movie_cubit.dart';
import 'package:xefi/src/presentation/widgets/video_player/video_control.dart';

class MoviePlayer extends StatefulWidget {
  final String thumbUrl;
  final EpisodeEntity episode;
  final List<ServerEntity> servers;

  const MoviePlayer({
    super.key,
    required this.thumbUrl,
    required this.episode,
    required this.servers,
  });

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  PlayMovieCubit get playMovieCubit => context.read<PlayMovieCubit>();

  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  VideoControls? videoControls;

  late Future<void>? _initializeVideoPlayerFuture;
  final double _ratioMovie = 16 / 9;

  EpisodeEntity get episode => widget.episode;
  EpisodeEntity? _episodeCurrent;

  @override
  void initState() {
    super.initState();
    _intVideoController(episode);
  }

  void _intVideoController(EpisodeEntity episodeCurrent) {
    _episodeCurrent = episodeCurrent;
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(_episodeCurrent?.linkM3u8 ?? ""));
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    print("player dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayMovieCubit, PlayMovieState>(
      builder: (context, state) {
        var newEpisode =
            state is PlayMovieChangeEpisode ? state.episode : _episodeCurrent;
        if (newEpisode != _episodeCurrent && newEpisode != null) {
          _videoPlayerController.dispose();
          _intVideoController(newEpisode);
        }
        return AspectRatio(
          aspectRatio: _ratioMovie,
          child: Container(
            color: Colors.black,
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  videoControls = VideoControls(
                    thumbUrl: widget.thumbUrl,
                    episode: _episodeCurrent ?? const EpisodeEntity(),
                    servers: widget.servers,
                    onChangeEpisode: (episode) {
                      changeEpisode(episode: episode);
                    },
                  );
                  _chewieController = ChewieController(
                    videoPlayerController: _videoPlayerController,
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    autoInitialize: true,
                    looping: false,
                    autoPlay: false,
                    //showControls: true,
                    customControls: videoControls,
                  );
                  final chewie = Chewie(controller: _chewieController);
                  videoControls?.bindUI(
                    videoPlayerController: _videoPlayerController,
                    chewieController: _chewieController,
                  );
                  return AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: chewie,
                  );
                }
                return Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.thumbUrl,
                      memCacheHeight: 400,
                      fit: BoxFit.cover,
                    ),
                    const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
      buildWhen: (p, c) => c is PlayMovieChangeEpisode,
    );
  }

  void changeEpisode({required EpisodeEntity episode}) {
    playMovieCubit.changeEpisode(episode: episode);
  }

  double getScale() {
    double videoRatio = _videoPlayerController.value.aspectRatio;

    if (videoRatio < _ratioMovie) {
      ///for tall videos, we just return the inverse of the controller aspect ratio
      return _ratioMovie / videoRatio;
    } else {
      ///for wide videos, divide the video AR by the fixed container AR
      ///so that the video does not over scale
      return videoRatio / _ratioMovie;
    }
  }
}
