part of 'visibility_speeds_cubit.dart';

sealed class VisibilitySpeedsState extends Equatable {
  const VisibilitySpeedsState();
}

final class VisibilitySpeedsInitial extends VisibilitySpeedsState {
  @override
  List<Object> get props => [];
}


final class VisibilitySpeedsControl extends VisibilitySpeedsState {
  final bool isVisible;

  const VisibilitySpeedsControl({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}