import 'package:xefi/src/injector.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/duration_control/duration_control_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/initialized_controller/initial_controller_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/play_control/play_control_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/video_player_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibilitity_thumbnail/visibility_thumbnail_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibility_controls/visibility_controls_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibility_episodes/visibility_episodes_cubit.dart';
import 'package:xefi/src/presentation/cubit/widgets/video_player/visibility_speeds/visibility_speeds_cubit.dart';

Future<void> injectionsVideoPlayer() async {
  injector
    ..registerFactory<InitialControllerCubit>(() => InitialControllerCubit())
    ..registerFactory<VisibilityThumbnailCubit>(
        () => VisibilityThumbnailCubit())
    ..registerFactory<VisibilityControlsCubit>(() => VisibilityControlsCubit())
    ..registerFactory<PlayControlCubit>(() => PlayControlCubit())
    ..registerFactory<DurationControlCubit>(() => DurationControlCubit())
    ..registerFactory<VisibilityEpisodesCubit>(() => VisibilityEpisodesCubit())
    ..registerFactory<VisibilitySpeedsCubit>(() => VisibilitySpeedsCubit())
  ;
}

void registerVideoPlayerCubit() {
  if (injector.isRegistered<VideoPlayerCubit>()) {
    injector.unregister<VideoPlayerCubit>();
  }
  injector.registerSingleton<VideoPlayerCubit>(VideoPlayerCubit(
    initialControllerCubit: injector(),
    visibilityThumbnailCubit: injector(),
    visibilityControlsCubit: injector(),
    playControlCubit: injector(),
    durationControlCubit: injector(),
    visibilityEpisodesCubit: injector(),
    visibilitySpeedsCubit: injector(),
  ));
}
