part of 'visibility_episodes_cubit.dart';

sealed class VisibilityEpisodesState extends Equatable {
  const VisibilityEpisodesState();
}

final class VisibilityEpisodesInitial extends VisibilityEpisodesState {
  @override
  List<Object> get props => [];
}


final class VisibilityEpisodesControl extends VisibilityEpisodesState {
  final bool isVisible;

  const VisibilityEpisodesControl({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}