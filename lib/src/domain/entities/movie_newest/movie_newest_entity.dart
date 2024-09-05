import 'package:equatable/equatable.dart';

import '../export_entities.dart';

class MovieNewestEntity extends Equatable {
  final Modified? modified;
  final String? id;
  final String? name;
  final String? slug;
  final String? originName;
  final String? posterUrl;
  final String? thumbUrl;
  final int? year;

  const MovieNewestEntity(
      {this.modified,
      this.id,
      this.name,
      this.slug,
      this.originName,
      this.posterUrl,
      this.thumbUrl,
      this.year});

  @override
  List<Object?> get props => [
        modified,
        id,
        name,
        slug,
        originName,
        posterUrl,
        thumbUrl,
        year,
      ];
}
