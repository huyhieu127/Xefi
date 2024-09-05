import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

part 'play_movie_state.dart';

class PlayMovieCubit extends Cubit<PlayMovieState> {
  PlayMovieCubit() : super(PlayMovieInitial());

  EpisodeEntity? episodeCurrent;

  void changeEpisode({
    required EpisodeEntity episode,
    String thumbnailUrl = "",
  }) {
    emit(PlayMovieChangeEpisode(episode: episode, thumbnailUrl: thumbnailUrl));
    episodeCurrent = episode;
  }
}
