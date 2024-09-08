part of 'initial_controller_cubit.dart';

sealed class InitializedControllerState extends Equatable {
  const InitializedControllerState();

  @override
  List<Object> get props => [];
}

final class ControllerInitial extends InitializedControllerState {}

final class ControllerInitialized extends InitializedControllerState {
  final EpisodeEntity episode;

  const ControllerInitialized({required this.episode});

  @override
  List<Object> get props => [episode];
}
