// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: (json['id'] as num).toInt(),
      postId: (json['post_id'] as num).toInt(),
      replyCommentId: (json['reply_comment_id'] as num?)?.toInt(),
      content: json['content'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.postId,
      'reply_comment_id': instance.replyCommentId,
      'content': instance.content,
      'created': instance.created.toIso8601String(),
    };
