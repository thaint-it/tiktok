class Endpoints {
  Endpoints._();

  static const String baseURL = 'http://localhost:8000/api/';
  static const String socketURL = 'localhost:9000';
  static const String baseFileURL =
      'https://8afa-2405-4802-703c-a330-f1df-8a90-2dff-b264.ngrok-free.app/';

  static const int receiveTimeout = 20000;

  static const int connectionTimeout = 30000;

  static const String login = '/auth/login';
  static const String fetchUsers = '/auth';
  static const String followerCategories = '/auth/follower_categories';
  static const String followerActivities = '/auth/activities';
  static const String rfToken = '/auth/refresh_jwt_token';
  static const String register = '/auth/create_user';
  static const String changeAvatar = '/auth/update_avatar';
  static const String notifyCount = '/auth/count_notify';
  static const String readNotify = '/auth/read_notify';

  static const String createPost = '/post/create_post';
  static const String post = '/post/list_post';
  static const String postById = '/post/post_by_id';
  static const String activityCategories = '/post/activity_categories';
  static const String activityById = '/post/activity_by_id';
  static const String postActivities = '/post/activities';
  static const String likePost = '/post/like_post';
  static const String favoritePost = '/post/favorite_post';
  static const String addComment = '/post/add_comment';
  static const String listComment = '/post/list_comment';
  static const String commentById = '/post/comment_by_id';

  static const String message = '/message';
  static const String messageById = '/message/get_by_id';
  static const String messageCategories = '/message/message_categories';
}
