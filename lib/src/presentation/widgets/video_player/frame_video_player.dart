import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/initialized_controller/initial_controller_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/video_player_cubit.dart';
import 'package:xefi/src/presentation/widgets/button_back.dart';
import 'package:xefi/src/presentation/widgets/video_player/video_control.dart';

class FrameVideoPlayer extends StatefulWidget {
  final VoidCallback? tapBackWhenInitialVideoController;

  const FrameVideoPlayer({super.key, this.tapBackWhenInitialVideoController});

  @override
  State<FrameVideoPlayer> createState() => FrameVideoPlayerState();
}

class FrameVideoPlayerState extends State<FrameVideoPlayer> {
  VideoPlayerCubit get _cubit => injector<VideoPlayerCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialControllerCubit, InitializedControllerState>(
      bloc: _cubit.initialControllerCubit,
      builder: (context, state) {
        final isInitialized = _cubit.videoPlayerController.value.isInitialized;
        if (state is ControllerInitialized && isInitialized) {
          return Stack(
            children: [
              Positioned.fill(
                child: Chewie(controller: _cubit.chewieController),
              ),
              const Positioned.fill(
                child: VideoControls(),
              ),
            ],
          );
        }
        return Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: _cubit.thumbUrl,
                memCacheHeight: 400,
                fit: BoxFit.cover,
              ),
            ),
            const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Visibility(
                visible: !_cubit.isPortrait,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ButtonBack(
                      onTap: () {
                        if (widget.tapBackWhenInitialVideoController != null) {
                          widget.tapBackWhenInitialVideoController!();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
