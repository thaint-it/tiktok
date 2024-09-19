import 'package:dio/dio.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/interceptor.dart';

class DioClient {
  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: Endpoints.baseURL,
            connectTimeout: Duration(milliseconds: Endpoints.connectionTimeout),
            receiveTimeout: Duration(milliseconds: Endpoints.receiveTimeout),
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            AuthorizationInterceptor(),
          ]);

  late final Dio dio;


}
