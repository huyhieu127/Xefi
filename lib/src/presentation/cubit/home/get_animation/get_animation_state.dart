part of 'get_animation_cubit.dart';

sealed class GetAnimationState extends Equatable {
  const GetAnimationState();

  @override
  List<Object?> get props => [];
}

final class GetAnimationInitial extends GetAnimationState {}

final class GetAnimationLoading extends GetAnimationState {
  const GetAnimationLoading();
}

final class GetAnimationSuccess extends GetAnimationState {
  final MovieGenreDataEntity? movieGenreDataEntity;

  const GetAnimationSuccess({required this.movieGenreDataEntity});

  @override
  List<Object?> get props => [movieGenreDataEntity];
}

final class GetAnimationError extends GetAnimationState {
  final String message;

  const GetAnimationError({required this.message});

  @override
  List<Object> get props => [message];
}
