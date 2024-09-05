part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomePagerIndicator extends HomeState {
  final int itemCount;
  final int currentIndex;
  final int oldIndex;
  final double offset;

  const HomePagerIndicator(
      this.itemCount, this.currentIndex, this.oldIndex, this.offset);

  @override
  List<Object> get props => [itemCount, currentIndex, oldIndex, offset];
}
