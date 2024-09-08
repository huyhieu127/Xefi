import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visibility_controls_state.dart';

class VisibilityControlsCubit extends Cubit<VisibilityControlsState> {
  VisibilityControlsCubit() : super(VisibilityControlsInitial());

  void setVisibilityControls({required bool isVisible}) {
    emit(VisibilityControls(isVisible: isVisible));
  }
}
