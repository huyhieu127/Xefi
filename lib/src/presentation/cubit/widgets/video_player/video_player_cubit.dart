import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/duration_control/duration_control_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/initialized_controller/initial_controller_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/play_control/play_control_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibilitity_thumbnail/visibility_thumbnail_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibility_controls/visibility_controls_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibility_episodes/visibility_episodes_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibility_speeds/visibility_speeds_cubit.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final InitialControllerCubit initialControllerCubit;
  final VisibilityControlsCubit visibilityControlsCubit;
  final VisibilityThumbnailCubit visibilityThumbnailCubit;
  final PlayControlCubit playControlCubit;
  final DurationControlCubit durationControlCubit;
  final VisibilityEpisodesCubit visibilityEpisodesCubit;
  final VisibilitySpeedsCubit visibilitySpeedsCubit;

  VideoPlayerCubit({
    required this.initialControllerCubit,
    required this.visibilityControlsCubit,
    required this.visibilityThumbnailCubit,
    required this.playControlCubit,
    required this.durationControlCubit,
    required this.visibilityEpisodesCubit,
    required this.visibilitySpeedsCubit,
  }) : super(VideoPlayerInitial());

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  late String thumbUrl;
  late EpisodeEntity episode;
  late List<ServerEntity> servers;

  double speed = 1;
  bool isPortrait = true;
  bool isEnd = false;

  //Update data
  void bindData({
    required String thumbUrl,
    required EpisodeEntity episode,
    required List<ServerEntity> servers,
  }) {
    this.thumbUrl = thumbUrl;
    this.episode = episode;
    this.servers = servers;
  }

  void disposeControllers() {
    try {
      if (videoPlayerController.value.isInitialized) {
        videoPlayerController.dispose();
        chewieController.dispose();
      }
    } catch (_) {
      rethrow;
    }
  }

  void changeEpisode({required EpisodeEntity episode}) {
    if (episode != this.episode) {
      this.episode = episode;
      emit(VideoPlayerChangeEpisode(episode: episode));
    }
  }

  void changeSpeed({required double speed}) {
    if (speed != this.speed) {
      this.speed = speed;
      emit(VideoPlayerChangeSpeed(speed: speed));
    }
  }
}
