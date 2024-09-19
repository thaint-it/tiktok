import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart'; // For the freezed-generated code
part 'comment.g.dart'; // For the json_serializable-generated code

@freezed
class Comment with _$Comment {
  const factory Comment({
   required int id,
  @JsonKey(name: 'user_id')required int userId,
   @JsonKey(name: 'post_id') required int postId,
   @JsonKey(name: 'reply_comment_id') int? replyCommentId,
  required String content,
  required DateTime created
  })=_Comment;
  
  // JSON serialization support
  factory Comment.fromJson(Map<String, dynamic> json) => 
  _$CommentFromJson(json);
 
}

