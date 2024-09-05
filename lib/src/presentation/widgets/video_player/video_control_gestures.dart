import 'package:xefi/src/domain/entities/export_entities.dart';

abstract class VideoControlGestures {
  void changeOrientation();

  void togglePlay();

  void rewind();

  void forward();

  void tapToVideo();

  //Speed
  void setSpeed({required double speed});

  void tapShowSpeed();

  void tapCloseSpeed();

  //Episodes
  void setEpisode({required EpisodeEntity episode});

  void tapShowEpisodes();

  void tapCloseEpisodes();
}
