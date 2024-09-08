part of 'duration_control_cubit.dart';

sealed class DurationControlState extends Equatable {
  const DurationControlState();
}

final class DurationControlInitial extends DurationControlState {
  @override
  List<Object> get props => [];
}

final class DurationControl extends DurationControlState {
  final Duration position;
  final Duration duration;
  final Duration buffered;

  const DurationControl({
    required this.position,
    required this.duration,
    required this.buffered,
  });

  @override
  List<Object> get props => [position, duration, buffered];
}
