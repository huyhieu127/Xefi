import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/usecases/firebase/firestore_usecases.dart';

part 'play_movie_state.dart';

class PlayMovieCubit extends Cubit<PlayMovieState> {
  final FirestoreUsecases _firestoreUsecases;

  PlayMovieCubit(this._firestoreUsecases) : super(PlayMovieInitial());

  EpisodeEntity? episodeCurrent;
  bool _isFavorite = false;

  void changeEpisode({
    required EpisodeEntity episode,
    String thumbnailUrl = "",
  }) {
    emit(PlayMovieChangeEpisode(episode: episode, thumbnailUrl: thumbnailUrl));
    episodeCurrent = episode;
  }

  void saveFavorite({required String slugName}) async {
    final result = await _firestoreUsecases.saveFavorite(
      slugName: slugName,
      isFavorite: !_isFavorite,
    );
  }

  void getFavorite({required String slugName}) async {
    _firestoreUsecases.getFavorite(slugName: slugName).listen(
      (result) {
        _isFavorite = result;
        emit(PlayMovieFavoriteChange(isFavorite: _isFavorite));
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }
}
