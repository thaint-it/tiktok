import 'package:json_annotation/json_annotation.dart';
import 'package:tiktok_clone/models/auth/user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int? id;
  @JsonKey(name: 'user_id')
  int? userId;
  String? content;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'from_user')
  User? fromUser;
  @JsonKey(name: 'to_user')
  User? toUser;
  bool? isRead;
  bool? isSending;

  Message(
      {this.id,
      this.userId,
      this.content,
      this.fromUser,
      this.toUser,
      this.isRead,
      this.isSending,
      this.createdAt});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        createdAt,
        fromUser,
        toUser,
        isRead,
        isSending,
      ];
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}


@JsonSerializable()
class MessagePagination {
  final List<Message>? messages;
  @JsonKey(name: 'has_next')
  final bool? hasNext;

  MessagePagination(this.messages, this.hasNext);
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [messages, hasNext];
  factory MessagePagination.fromJson(Map<String, dynamic> json) =>
      _$MessagePaginationFromJson(json);
  Map<String, dynamic> toJson() => _$MessagePaginationToJson(this);
}
