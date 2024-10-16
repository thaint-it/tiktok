import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tiktok_clone/api/client.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/exception.dart';
import 'package:tiktok_clone/models/activities/activities.dart';
import 'package:tiktok_clone/models/auth/user.dart';

class AuthService {
  final DioClient _dio;

  AuthService(this._dio);

  Future<UserResponse?> login({required UserLogin user}) async {
    try {
      final response =
          await _dio.dio.post(Endpoints.login, data: user.toJson());
      return UserResponse.fromJson(response.data);
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<UserResponse?> register({required UserLogin user}) async {
    try {
      final response =
          await _dio.dio.post(Endpoints.register, data: user.toJson());
      return UserResponse.fromJson(response.data);
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<UserAvatar?> changeAvatar(
      {required userId, required File avatar}) async {
    try {
      // Create form data
      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(avatar.path),
        'user_id': userId,
      });
      final response =
          await _dio.dio.post(Endpoints.changeAvatar, data: formData);
      return UserAvatar.fromJson(response.data);
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<User>?> fetchUsers() async {
    try {
      final response = await _dio.dio.get(Endpoints.fetchUsers);
      return (response.data as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<FollowerActivity?> followerCategory() async {
    try {
      final response = await _dio.dio.get(Endpoints.followerCategories);
      return FollowerActivity.fromJson(response.data);
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<List<FollowerActivity>?> followerActivities() async {
    try {
      final response = await _dio.dio.get(Endpoints.followerActivities);
      return (response.data as List<dynamic>?)
          ?.map((e) => FollowerActivity.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<int> notifyCount() async {
    try {
      final response = await _dio.dio.get(Endpoints.notifyCount);
      return response.data;
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<bool?> readNotify(data) async {
    try {
      await _dio.dio.post(Endpoints.readNotify, data: data);
      return true;
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}
