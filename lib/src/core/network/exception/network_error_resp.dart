import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'network_error_resp.g.dart';

@JsonSerializable()
class NetworkErrorResp extends Equatable {
  @JsonKey(name: 'status')
  final String? status;

  const NetworkErrorResp(this.status);

  factory NetworkErrorResp.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    if (status is bool) {
      json['status'] = status ? "success" : "failed";
    }
    return _$NetworkErrorRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NetworkErrorRespToJson(this);

  @override
  List<Object?> get props => [status];
}
