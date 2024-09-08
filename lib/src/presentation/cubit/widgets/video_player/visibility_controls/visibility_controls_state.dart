part of 'visibility_controls_cubit.dart';

sealed class VisibilityControlsState extends Equatable {
  const VisibilityControlsState();

  @override
  List<Object> get props => [];
}

final class VisibilityControlsInitial extends VisibilityControlsState {}

final class VisibilityControls extends VisibilityControlsState {
  final bool isVisible;

  const VisibilityControls({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}
