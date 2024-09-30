// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      thumbnail: json['thumbnail'] as String?,
      userId: json['user_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      isPrivate: json['is_private'] as bool?,
      viewCount: (json['view_count'] as num?)?.toInt(),
      commentCount: (json['comment_count'] as num?)?.toInt(),
      likeCount: (json['like_count'] as num?)?.toInt(),
      favoriteCount: (json['favorite_count'] as num?)?.toInt(),
      shareCount: (json['share_count'] as num?)?.toInt(),
      commenter: (json['commenter'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'is_private': instance.isPrivate,
      'view_count': instance.viewCount,
      'comment_count': instance.commentCount,
      'like_count': instance.likeCount,
      'favorite_count': instance.favoriteCount,
      'share_count': instance.shareCount,
      'commenter': instance.commenter,
      'user': instance.user,
    };

PostPagination _$PostPaginationFromJson(Map<String, dynamic> json) =>
    PostPagination(
      (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['has_next'] as bool?,
    );

Map<String, dynamic> _$PostPaginationToJson(PostPagination instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'has_next': instance.hasNext,
    };
