part of 'play_control_cubit.dart';

sealed class PlayControlState extends Equatable {
  const PlayControlState();
}

final class PlayControlInitial extends PlayControlState {
  @override
  List<Object> get props => [];
}


final class PlayControl extends PlayControlState {
  final bool isPlaying;

  const PlayControl({required this.isPlaying});

  @override
  List<Object> get props => [isPlaying];
}