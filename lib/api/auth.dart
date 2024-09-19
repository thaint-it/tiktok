import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tiktok_clone/api/client.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/exception.dart';
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
}
