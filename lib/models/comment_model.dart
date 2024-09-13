class CommentModel {
  final int id;
  final String text;
  final String fullName;
  final String? avatar;
  final DateTime? date;
  final int? parentId;
  final List<CommentModel> childComments;
  final String time;
  final bool? isCreator;

  CommentModel({
    required this.id,
    required this.text,
    required this.fullName,
    this.avatar,
    this.date,
    this.childComments = const [],
    this.parentId,
    required this.time,
    this.isCreator = false,
  });
}
