import 'package:equatable/equatable.dart';

import '../export_entities.dart';

class MovieGenreEntity extends Equatable {
  final Modified? modified;
  final String? id;
  final String? name;
  final String? slug;
  final String? originName;
  final String? type;
  final String? posterUrl;
  final String? thumbUrl;
  final bool? subDocQuyen;
  final bool? chieuRap;
  final String? time;
  final String? episodeCurrent;
  final String? quality;
  final String? lang;
  final int? year;
  final List<Category>? category;
  final List<Country>? country;

  const MovieGenreEntity({
    this.modified,
    this.id,
    this.name,
    this.slug,
    this.originName,
    this.type,
    this.posterUrl,
    this.thumbUrl,
    this.subDocQuyen,
    this.chieuRap,
    this.time,
    this.episodeCurrent,
    this.quality,
    this.lang,
    this.year,
    this.category,
    this.country,
  });

  @override
  List<Object?> get props => [
        modified,
        id,
        name,
        slug,
        originName,
        type,
        posterUrl,
        thumbUrl,
        subDocQuyen,
        chieuRap,
        time,
        episodeCurrent,
        quality,
        lang,
        year,
        category,
        country,
      ];
}
