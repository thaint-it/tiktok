import 'package:json_annotation/json_annotation.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/models/post/post.dart';

part 'activities.g.dart';

@JsonSerializable()
class FollowerActivity {
  final int? id;
  final User? follower;
  final User? following;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'is_read')
  final bool? isRead;

  FollowerActivity(this.id, this.follower,this.following,this.createdAt,this.isRead);
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, follower,following,createdAt,isRead];
  factory FollowerActivity.fromJson(Map<String, dynamic> json) =>
      _$FollowerActivityFromJson(json);
  Map<String, dynamic> toJson() => _$FollowerActivityToJson(this);
}


@JsonSerializable()
class Activity {
  final int? id;
  final User? user;
  final ActivityPost? post;
  final String? action;
  final String? content;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'is_read')
  final bool? isRead;

  Activity(this.id, this.user,this.post,this.action,this.content,this.createdAt,this.isRead);
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, user,post,action,content,createdAt,isRead];
  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
