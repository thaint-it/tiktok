import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tiktok_clone/api/client.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/exception.dart';
import 'package:tiktok_clone/models/post/post.dart';

class PostService {
  final DioClient _dio;

  PostService(this._dio);

  Future<PostPagination> fetchPosts({int page = 1, int perPage = 5}) async {
    try {
      final response = await _dio.dio.get(
        Endpoints.post,
        queryParameters: {
          'page': page,
          'per_page':
              perPage, // Adjust these names based on your API's expected params
        },
      );
      PostPagination paginationData = PostPagination.fromJson(response.data);
      return paginationData;
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<bool?> createPost({required FormData data}) async {
    try {
      await _dio.dio.post(Endpoints.createPost, data: data);
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
