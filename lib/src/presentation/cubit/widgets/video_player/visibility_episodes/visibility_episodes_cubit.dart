import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visibility_episodes_state.dart';

class VisibilityEpisodesCubit extends Cubit<VisibilityEpisodesState> {
  VisibilityEpisodesCubit() : super(VisibilityEpisodesInitial());

  void setVisibilityEpisodesControl({required bool isVisible}) {
    emit(VisibilityEpisodesControl(isVisible: isVisible));
  }
}
