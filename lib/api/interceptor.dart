import 'package:dio/dio.dart';

// ignore: constant_identifier_names
const String API_KEY =
    'cdc9a8ca8aa17b6bed3aa3611a835105bbb4632514d7ca8cf55dbbc5966a7cae';

//* Request methods PUT, POST, PATCH, DELETE needs access token,
//* which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_needAuthorizationHeader(options)) {
      options.headers['Authorization'] = 'Bearer $API_KEY';
    }
    super.onRequest(options, handler);
  }

  bool _needAuthorizationHeader(RequestOptions options) {
    print("path ${options.uri.path}");
    if (options.uri.path == '/api/auth/login'||options.uri.path == '/api/auth/create_user') {
      return false;
    } else {
      return true;
    }
  }
}