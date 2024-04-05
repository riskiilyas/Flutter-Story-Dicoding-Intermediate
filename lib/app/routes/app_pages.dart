import '../../app/modules/map_story_module/map_story_page.dart';
import '../../app/modules/map_story_module/map_story_bindings.dart';
import '../../app/modules/splash_module/splash_page.dart';
import '../../app/modules/splash_module/splash_bindings.dart';
import '../../app/modules/detail_story_module/detail_story_page.dart';
import '../../app/modules/detail_story_module/detail_story_bindings.dart';
import '../../app/modules/add_story_module/add_story_page.dart';
import '../../app/modules/add_story_module/add_story_bindings.dart';
import '../../app/modules/register_module/register_page.dart';
import '../../app/modules/register_module/register_bindings.dart';
import '../../app/modules/login_module/login_page.dart';
import '../../app/modules/login_module/login_bindings.dart';
import '../../app/modules/home_module/home_bindings.dart';
import '../../app/modules/home_module/home_page.dart';
import 'package:get/get.dart';

part './app_routes.dart';

/// GetX Generator - fb.com/htngu.99
///

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      participatesInRootNavigator: true,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.ADD_STORY,
      page: () => const AddStoryPage(),
      binding: AddStoryBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_STORY,
      page: () => const DetailStoryPage(),
      binding: DetailStoryBinding(),
    ),
    GetPage(
      name: Routes.MAP_STORY,
      page: () => const MapStoryPage(),
      binding: MapStoryBinding(),
    ),
  ];

// final GoRouter router = GoRouter(
//   routes: <GoRoute>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) => (),
//     ),
//     GoRoute(
//       path: '/another-screen',
//       builder: (BuildContext context, GoRouterState state) => e,
//     ),
//   ],
// );
}
