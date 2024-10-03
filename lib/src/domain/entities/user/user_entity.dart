import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  final String? email;
  final String? displayName;
  final String? uid;
  final String? photoURL;

  const UserEntity({
    required this.email,
    required this.displayName,
    required this.uid,
    required this.photoURL,
  });

  @override
  List<Object?> get props => [email, displayName, uid, photoURL];

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

UserEntity toUserEntity(User user) {
  return UserEntity(
    email: user.email,
    displayName: user.displayName,
    uid: user.uid,
    photoURL: user.photoURL,
  );
}
