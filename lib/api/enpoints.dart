class Endpoints {
  Endpoints._();

  static const String baseURL = 'http://localhost:8000/api/';

  static const int receiveTimeout = 5000;

  static const int connectionTimeout = 3000;

  static const String login = '/auth/login';
    static const String rfToken = '/auth/refresh_jwt_token';
  static const String register = '/auth/create_user';
  static const String changeAvatar = '/auth/update_avatar';
}