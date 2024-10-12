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
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      parentId: (json['parent_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'post_id': instance.postId,
      'reply_comment_id': instance.replyCommentId,
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
      'children': instance.children,
      'user': instance.user,
      'parent_id': instance.parentId,
    };
