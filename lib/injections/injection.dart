import 'package:get_it/get_it.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/api/client.dart';
import 'package:tiktok_clone/api/message.dart';
import 'package:tiktok_clone/api/notification.dart';
import 'package:tiktok_clone/api/post.dart';
import 'package:tiktok_clone/storage/storage.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton<StorageService>(() => StorageService());
  getIt.registerLazySingleton<DioClient>(
      () => DioClient(getIt<StorageService>()));
  getIt.registerLazySingleton<AuthService>(
      () => AuthService(getIt<DioClient>()));
  getIt.registerLazySingleton<PostService>(
      () => PostService(getIt<DioClient>()));
   getIt.registerLazySingleton<MessageService>(
      () => MessageService(getIt<DioClient>()));

  getIt.registerLazySingleton<NoticationService>(
      () => NoticationService());
}
