import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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

UserEntity gmailToUserEntity(User user) {
  return UserEntity(
    email: user.email,
    displayName: user.displayName,
    uid: user.uid,
    photoURL: user.photoURL,
  );
}

Future<UserEntity> facebookToUserEntity(AccessToken accessToken) async {

  final userData = await FacebookAuth.instance.getUserData(
    fields: 'name,email,picture', //picture.width(200) resize picture
  );

  final String? name = userData['name'];
  final String? email = userData['email'];
  final String? photoURL = userData['picture']['data']['url'];

  return UserEntity(
    email: email,
    displayName: name,
    uid: accessToken.userId,
    photoURL: photoURL,
  );
}
