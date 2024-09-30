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
  DateTime? created;
  List<Comment>? children;
  @JsonKey(name: 'is_creator')
  bool? isCreator;
  User? user;

  Comment(
      {this.id,
      this.userId,
      this.postId,
      this.replyCommentId,
      required this.content,
      required this.created,
      required this.children,
      this.user,
      this.isCreator});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        userId,
        postId,
        replyCommentId,
        content,
        created,
        children,
        user,
        isCreator
      ];
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
