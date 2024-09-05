import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void setCurrentPageIndex(
      {required int size,
      required int currentIndex,
      required int oldIndex,
      required double offset}) {
    emit(HomePagerIndicator(size, currentIndex, oldIndex, offset));
  }
}
