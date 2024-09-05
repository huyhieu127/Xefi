import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'modified.g.dart';

@JsonSerializable()
class Modified extends Equatable {
  final String? time;

  const Modified({this.time});

  @override
  List<Object?> get props => [time];

  factory Modified.fromJson(Map<String, dynamic> json) =>
      _$ModifiedFromJson(json);

  Map<String, dynamic> toJson() => _$ModifiedToJson(this);
}
