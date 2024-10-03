// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      email: json['email'] as String?,
      displayName: json['name'] as String?,
      uid: json['id'] as String?,
      photoURL: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.displayName,
      'id': instance.uid,
      'avatarUrl': instance.photoURL,
    };
