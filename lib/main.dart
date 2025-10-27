import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/main_screen.dart';
import 'screens/login_screen.dart';
import 'constants/colors.dart';
import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('prayers');
  await Hive.openBox('habits');

  // Initialize Auth Controller as permanent
  Get.put(AuthController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return GetMaterialApp(
      title: 'MuslimMate',
      debugShowCheckedModeBanner: false,
      initialRoute: authController.isAuthenticated ? '/home' : '/login',
      getPages: [
        GetPage(
            name: '/login',
            page: () => LoginScreen(),
            transition: Transition.fadeIn),
        GetPage(
            name: '/home',
            page: () => MainScreen(),
            middlewares: [AuthMiddleware()],
            transition: Transition.fadeIn),
      ],
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accent,
        ),
      ),
    );
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    return authController.isAuthenticated
        ? null
        : RouteSettings(name: '/login');
  }
}
