part of 'visibility_thumbnail_cubit.dart';

sealed class VisibilityThumbnailState extends Equatable {
  const VisibilityThumbnailState();

  @override
  List<Object> get props => [];
}

final class VisibilityThumbnailInitial extends VisibilityThumbnailState {}

final class VisibilityThumbnail extends VisibilityThumbnailState {
  final bool isVisible;

  const VisibilityThumbnail({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}
