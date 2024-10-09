// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowerActivity _$FollowerActivityFromJson(Map<String, dynamic> json) =>
    FollowerActivity(
      (json['id'] as num?)?.toInt(),
      json['follower'] == null
          ? null
          : User.fromJson(json['follower'] as Map<String, dynamic>),
      json['following'] == null
          ? null
          : User.fromJson(json['following'] as Map<String, dynamic>),
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['is_read'] as bool?,
    );

Map<String, dynamic> _$FollowerActivityToJson(FollowerActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'follower': instance.follower,
      'following': instance.following,
      'created_at': instance.createdAt?.toIso8601String(),
      'is_read': instance.isRead,
    };

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      (json['id'] as num?)?.toInt(),
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['post'] == null
          ? null
          : ActivityPost.fromJson(json['post'] as Map<String, dynamic>),
      json['action'] as String?,
      json['content'] as String?,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['is_read'] as bool?,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'action': instance.action,
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
      'is_read': instance.isRead,
    };
