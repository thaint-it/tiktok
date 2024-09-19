import 'package:get_it/get_it.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/api/client.dart';
import 'package:tiktok_clone/storage/storage.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<StorageService>(() => StorageService());
  getIt.registerLazySingleton<AuthService>(
      () => AuthService(getIt<DioClient>()));
}
