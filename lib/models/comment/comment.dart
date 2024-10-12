import 'package:json_annotation/json_annotation.dart';
import 'package:tiktok_clone/models/auth/user.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int? id;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'post_id')
  int? postId;
  @JsonKey(name: 'reply_comment_id')
  int? replyCommentId;
  String? content;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  List<Comment>? children;
  User? user;
  @JsonKey(name: 'parent_id')
  int? parentId;

  Comment(
      {this.id,
      this.userId,
      this.postId,
      this.replyCommentId,
      required this.content,
      required this.createdAt,
      required this.children,
      this.user,
      this.parentId});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        userId,
        postId,
        replyCommentId,
        content,
        createdAt,
        children,
        user
        ,parentId
      ];
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

