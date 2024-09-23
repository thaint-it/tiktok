import 'package:provider/provider.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/auth/user_data.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/route/route_constants.dart';
import 'package:tiktok_clone/storage/storage.dart';
import 'package:tiktok_clone/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/route/router.dart' as router;

void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();

  StorageService storageService = getIt<StorageService>();

  UserProvider userProvider = UserProvider();

  // Fetch user data from SharedPreferences and initialize UserProvider
  final user = await storageService.getUser();
  if (user != null) {
    userProvider.setUser(UserData(
        id: user.id,
        userId: user.userId,
        avatar: user.avatar,
        username: user.username,
        email: user.email));
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => userProvider),
        // Thêm các provider khác ở đây
      ],
      child: MyApp(),
    ),
  );
}

// Thanks for using our template. You are using the free version of the template.
// 🔗 Full template: https://theflutterway.gumroad.com/l/fluttershop

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiktok clone',
      theme: AppTheme.lightTheme(context),
      // Dark theme is inclided in the Full template
      themeMode: ThemeMode.light,
      onGenerateRoute: router.generateRoute,
      initialRoute: entryPointScreenRoute,
    );
  }
}
