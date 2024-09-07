import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:xefi/src/core/utils/screen_utils.dart';

class VideoPlayerFullscreen extends StatefulWidget {
  final ChewieController chewieController;
  final VideoPlayerController videoPlayerController;

  const VideoPlayerFullscreen({
    super.key,
    required this.videoPlayerController,
    required this.chewieController,
  });

  @override
  State<VideoPlayerFullscreen> createState() => _VideoPlayerFullscreenState();
}

class _VideoPlayerFullscreenState extends State<VideoPlayerFullscreen> {
  get _videoPlayerController => widget.videoPlayerController;

  get _chewieController => widget.chewieController;

  @override
  void initState() {
    super.initState();
    enterFullScreen();
  }

  @override
  void dispose() {
    //_streamShowEpisodes.dispose();
    exitFullScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ],
      ),
    );
  }
}
