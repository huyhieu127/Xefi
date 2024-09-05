part of 'get_newest_cubit.dart';

sealed class GetNewestState extends Equatable {
  const GetNewestState();

  @override
  List<Object> get props => [];
}

final class GetNewestInitial extends GetNewestState {}

final class GetNewestLoading extends GetNewestState {
  const GetNewestLoading();
}

final class GetNewestSuccess extends GetNewestState {
  final List<MovieNewestEntity> newestList;

  const GetNewestSuccess({required this.newestList});

  @override
  List<Object> get props => [newestList];
}

final class GetNewestError extends GetNewestState {
  final String message;

  const GetNewestError({required this.message});

  @override
  List<Object> get props => [message];
}
