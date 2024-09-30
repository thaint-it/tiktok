// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      postId: (json['post_id'] as num?)?.toInt(),
      replyCommentId: (json['reply_comment_id'] as num?)?.toInt(),
      content: json['content'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      isCreator: json['is_creator'] as bool?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'post_id': instance.postId,
      'reply_comment_id': instance.replyCommentId,
      'content': instance.content,
      'created': instance.created?.toIso8601String(),
      'children': instance.children,
      'is_creator': instance.isCreator,
      'user': instance.user,
    };
