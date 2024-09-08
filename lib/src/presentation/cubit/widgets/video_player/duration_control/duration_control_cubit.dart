import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'duration_control_state.dart';

class DurationControlCubit extends Cubit<DurationControlState> {
  DurationControlCubit() : super(DurationControlInitial());

  void updateDuration({
    required Duration position,
    required Duration duration,
    required Duration buffered,
  }) {
    emit(DurationControl(
      position: position,
      duration: duration,
      buffered: buffered,
    ));
  }
}
