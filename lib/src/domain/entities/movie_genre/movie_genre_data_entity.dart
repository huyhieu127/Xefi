import 'package:equatable/equatable.dart';

import '../export_entities.dart';

class MovieGenreDataEntity extends Equatable {
  const MovieGenreDataEntity({
    this.movies,
    this.params,
    this.typeList,
    this.appDomainFrontend,
    this.appDomainCdnImage,
  });

  final List<MovieGenreEntity>? movies;
  final Params? params;
  final String? typeList;
  final String? appDomainFrontend;
  final String? appDomainCdnImage;

  @override
  List<Object?> get props => [
        movies,
        params,
        typeList,
        appDomainFrontend,
        appDomainCdnImage,
      ];
}
