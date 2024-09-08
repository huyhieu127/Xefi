import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

part 'initial_controller_state.dart';

class InitialControllerCubit extends Cubit<InitializedControllerState> {
  InitialControllerCubit() : super(ControllerInitial());

  //Update state
  void videoControllerInitialized({required EpisodeEntity episode}) {
    emit(ControllerInitialized(episode: episode));
  }
}
