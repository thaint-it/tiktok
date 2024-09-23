import 'package:dio/dio.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/interceptor.dart';
import 'package:tiktok_clone/storage/storage.dart';

class DioClient {
  late final Dio dio;
  final StorageService _storageService;

  DioClient(this._storageService)
      : dio = Dio(
          BaseOptions(
            baseUrl: Endpoints.baseURL,
            connectTimeout: Duration(milliseconds: Endpoints.connectionTimeout),
            receiveTimeout: Duration(milliseconds: Endpoints.receiveTimeout),
            responseType: ResponseType.json,
          ),
        ) {
    dio.interceptors.add(AuthorizationInterceptor(dio, _storageService));
  }
}
