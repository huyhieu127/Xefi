import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'play_control_state.dart';

class PlayControlCubit extends Cubit<PlayControlState> {
  PlayControlCubit() : super(PlayControlInitial());

  void setPlay({required bool isPlay}) {
    emit(PlayControl(isPlaying: isPlay));
  }
}
