import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'created.g.dart';

@JsonSerializable()
class Created extends Equatable {
  final String? time;

  const Created({this.time});

  @override
  List<Object?> get props => [time];

  factory Created.fromJson(Map<String, dynamic> json) =>
      _$CreatedFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedToJson(this);
}
