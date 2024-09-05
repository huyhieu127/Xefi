import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

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
    setLandscape();
  }

  @override
  void dispose() {
    //_streamShowEpisodes.dispose();
    setPortrait();
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

  Future setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future setPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
