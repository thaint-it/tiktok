import 'package:json_annotation/json_annotation.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/models/comment/comment.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int? id;
  final String? url;
  final String? thumbnail;
  @JsonKey(name: 'user_id') // Maps 'user_id' from JSON to 'userId'
  final String? userId;
  final String? title;
  final String? description;
  @JsonKey(name: 'is_private')
  final bool? isPrivate;
  @JsonKey(name: 'view_count')
  final int? viewCount;
  @JsonKey(name: 'comment_count')
  final int? commentCount;
  @JsonKey(name: 'like_count')
  final int? likeCount;
  @JsonKey(name: 'favorite_count')
  final int? favoriteCount;
  @JsonKey(name: 'share_count')
  final int? shareCount;
  final List<Comment>? commenter;
  final User? user;

  Post(
      {this.id,
      this.url,
      this.thumbnail,
      this.userId,
      this.title,
      this.description,
      this.isPrivate,
      this.viewCount,
      this.commentCount,
      this.likeCount,
      this.favoriteCount,
      this.shareCount,
      this.commenter,
      this.user});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        url,
        thumbnail,
        userId,
        title,
        description,
        isPrivate,
        viewCount,
        commentCount,
        likeCount,
        favoriteCount,
        shareCount,
        commenter,
        user
      ];
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class ActivityPost {
  final int? id;
  final String? url;
  final String? thumbnail;


  ActivityPost(
      {this.id,
      this.url,
      this.thumbnail,
});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        url,
        thumbnail,
       
      ];
  factory ActivityPost.fromJson(Map<String, dynamic> json) => _$ActivityPostFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityPostToJson(this);
}


@JsonSerializable()
class PostPagination {
  final List<Post>? posts;
  @JsonKey(name: 'has_next')
  final bool? hasNext;

  PostPagination(this.posts, this.hasNext);
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [posts, hasNext];
  factory PostPagination.fromJson(Map<String, dynamic> json) =>
      _$PostPaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PostPaginationToJson(this);
}
