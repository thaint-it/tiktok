// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      avatar: json['avatar'] as String?,
      username: json['username'] as String?,
      tiktokId: json['tiktok_id'] as String?,
      email: json['email'] as String?,
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'username': instance.username,
      'tiktok_id': instance.tiktokId,
      'email': instance.email,
      'bio': instance.bio,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      jwtToken: json['jwt_token'] as String,
      refreshToken: json['refresh_token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'jwt_token': instance.jwtToken,
      'refresh_token': instance.refreshToken,
      'user': instance.user,
    };

UserLogin _$UserLoginFromJson(Map<String, dynamic> json) => UserLogin(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginToJson(UserLogin instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

UserAvatar _$UserAvatarFromJson(Map<String, dynamic> json) => UserAvatar(
      userId: json['user_id'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$UserAvatarToJson(UserAvatar instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'avatar': instance.avatar,
    };
