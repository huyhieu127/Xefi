part of 'get_detail_cubit.dart';

sealed class GetDetailState extends Equatable {
  const GetDetailState();

  @override
  List<Object?> get props => [];
}

final class GetDetailInitial extends GetDetailState {}

final class GetDetailLoading extends GetDetailState {
  const GetDetailLoading();
}

final class GetDetailSuccess extends GetDetailState {
  final MovieDetailDataEntity? movieDetailData;

  const GetDetailSuccess({required this.movieDetailData});

  @override
  List<Object?> get props => [movieDetailData];
}

final class GetDetailError extends GetDetailState {
  final String message;

  const GetDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
