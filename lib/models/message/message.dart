import 'package:json_annotation/json_annotation.dart';
import 'package:tiktok_clone/models/auth/user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int? id;
  @JsonKey(name: 'user_id')
  int? userId;
  String? content;
  DateTime? created;
  User? user;

  Message(
      {this.id,
      this.userId,
      this.content,
      this.user});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        created,
        user,
      ];
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
