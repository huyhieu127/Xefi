import 'package:equatable/equatable.dart';

import '../export_entities.dart';

class MovieDetailEntity extends Equatable {
  const MovieDetailEntity({
    this.created,
    this.modified,
    this.id, //_id
    this.name,
    this.slug,
    this.originName, //origin_name
    this.content,
    this.type,
    this.status,
    this.posterUrl, //poster_url
    this.thumbUrl, //thumb_url
    this.isCopyright, //is_copyright
    this.subDocQuyen, //sub_docquyen
    this.chieuRap,
    this.trailerUrl, //trailer_url
    this.time,
    this.episodeCurrent, //episode_current
    this.episodeTotal, //episode_total
    this.quality,
    this.lang,
    this.notify,
    this.showTimes,
    this.year,
    this.view,
    this.actor,
    this.director,
    this.category,
    this.country,
  });

  final Created? created;
  final Modified? modified;
  final String? id; //_id
  final String? name;
  final String? slug;
  final String? originName; //origin_name
  final String? content;
  final String? type;
  final String? status;
  final String? posterUrl; //poster_url
  final String? thumbUrl; //thumb_url
  final bool? isCopyright; //is_copyright
  final bool? subDocQuyen; //sub_docquyen
  final bool? chieuRap;
  final String? trailerUrl; //trailer_u;l
  final String? time;
  final String? episodeCurrent; //episode_current
  final String? episodeTotal; //episode_total
  final String? quality;
  final String? lang;
  final String? notify;
  final String? showTimes; //showtimes
  final int? year;
  final int? view;
  final List<String>? actor;
  final List<String>? director;
  final List<Category>? category;
  final List<Country>? country;

  @override
  List<Object?> get props => [
        created,
        modified,
        id,
        name,
        slug,
        originName,
        content,
        type,
        status,
        posterUrl,
        thumbUrl,
        isCopyright,
        subDocQuyen,
        chieuRap,
        trailerUrl,
        time,
        episodeCurrent,
        episodeTotal,
        quality,
        lang,
        notify,
        showTimes,
        year,
        view,
        actor,
        director,
        category,
        country,
      ];
}
