class HistoryPostModel {
  final int id;
  final String thumbnail;

  final int viewCount;
  final bool? pined;

  HistoryPostModel({
    required this.id,
    required this.thumbnail,
    required this.viewCount,
    this.pined,
  });
}
