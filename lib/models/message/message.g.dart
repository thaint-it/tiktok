// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      content: json['content'] as String?,
      fromUser: json['from_user'] == null
          ? null
          : User.fromJson(json['from_user'] as Map<String, dynamic>),
      toUser: json['to_user'] == null
          ? null
          : User.fromJson(json['to_user'] as Map<String, dynamic>),
      isRead: json['isRead'] as bool?,
      isSending: json['isSending'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
      'from_user': instance.fromUser,
      'to_user': instance.toUser,
      'isRead': instance.isRead,
      'isSending': instance.isSending,
    };

MessagePagination _$MessagePaginationFromJson(Map<String, dynamic> json) =>
    MessagePagination(
      (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['has_next'] as bool?,
    );

Map<String, dynamic> _$MessagePaginationToJson(MessagePagination instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'has_next': instance.hasNext,
    };
