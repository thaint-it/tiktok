import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tiktok_clone/api/client.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/exception.dart';
import 'package:tiktok_clone/models/message/message.dart';

class MessageService {
  final DioClient _dio;

  MessageService(this._dio);

  Future<MessagePagination> fetchMessages(
      {required int userId, int page = 1, int perPage = 20}) async {
    try {
      final response = await _dio.dio.get(
        Endpoints.message,
        queryParameters: {
          "receiver_id": userId,
          'page': page,
          'per_page':
              perPage, // Adjust these names based on your API's expected params
        },
      );
      MessagePagination paginationData =
          MessagePagination.fromJson(response.data);
      return paginationData;
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<Message> getMessages({required int id}) async {
    try {
      final response = await _dio.dio.get(
        Endpoints.messageById,
        queryParameters: {
          "id": id,
        },
      );
      return Message.fromJson(response.data);
    } on DioException catch (err) {
      final errorMessage = DioClientException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<bool?> createMessage({required data}) async {
    try {
      await _dio.dio.post(Endpoints.message, data: data);
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
