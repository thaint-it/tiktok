import 'package:dio/dio.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/storage/storage.dart';

//* Request methods PUT, POST, PATCH, DELETE needs access token,
//* which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  final Dio _dio;
  final StorageService _storageService;
  AuthorizationInterceptor(this._dio, this._storageService);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await _storageService.getToken();
    if (_needAuthorizationHeader(options) && token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    _refreshTokenAndResolveError(err, handler);
  }

  bool _needAuthorizationHeader(RequestOptions options) {
    final List<String> unAuthApis = [
      "/api/auth/login",
      "/api/auth/create_user",
      "/api/auth/refresh_jwt_token"
    ];
    return !unAuthApis.contains(options.uri.path);
  }

  /// Refreshes the user token and retries the request.
  /// If the token refresh fails, the error will be passed to the next interceptor.
  void _refreshTokenAndResolveError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final rfToken = await _storageService.getRFToken();
      try {
        // refresh token
        final response = await _dio
            .post(Endpoints.rfToken, data: {"refresh_token": rfToken});
        final user = UserResponse.fromJson(response.data);
        // Update new access_token, rf_token
        _storageService.setRFToken(user.refreshToken);
        _storageService.setToken(user.jwtToken);
        // recall error requests
        err.requestOptions.headers['Authorization'] = 'Bearer ${user.jwtToken}';
        // recall error apis
        final refreshResponse = await Dio().fetch(err.requestOptions);
        return handler.resolve(refreshResponse);
      } catch (e) {
        await _storageService.clearSharedPreferences();
        if (e is DioException) {
          return handler.next(e);
        }

        return handler.next(err);
      }
    }
  }
}
