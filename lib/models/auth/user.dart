// https://github.com/thecodexhub/flutter-dio-example/blob/main/lib/models/user.dart
// flutter pub run build_runner build -delete-confilicting-outputs

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int? id;
  final String? avatar;
  final String? username;
  @JsonKey(name: 'user_id') // Maps 'user_id' from JSON to 'userId'
  final String? userId;
  final String? email;
  final String? bio;

  User(
      {this.id, this.avatar, this.username, this.userId, this.email, this.bio});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, avatar, username, userId, email, bio];
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserResponse extends Equatable {
  @JsonKey(name: 'jwt_token') // Maps 'user_id' from JSON to 'userId'
  final String jwtToken;
  @JsonKey(name: 'refresh_token') // Maps 'user_id' from JSON to 'userId'
  final String refreshToken;
  final User user;
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [jwtToken, refreshToken, user];

  UserResponse(
      {required this.jwtToken, required this.refreshToken, required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class UserLogin extends Equatable {
  final String email;
  final String password;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [email, password];

  UserLogin({required this.email, required this.password});

  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);
}
