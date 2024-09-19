class CommentData {
  CommentData(
      {required this.id,
      required this.userId,
      required this.postId,
      this.replyCommentId,
      required this.content,
      required this.created,
      this.avatar,
      required this.userName,
     required this.children,
      this.isCreator});
  int id;
  int userId;
  int postId;
  int? replyCommentId;
  String content;
  DateTime created;
  String? avatar;
  String userName;
  List<CommentData> children;
  bool? isCreator;
}
