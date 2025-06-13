import 'package:ecommerce_task_test/routes/routes.dart';
import 'package:ecommerce_task_test/routes/unknown_routes.dart';
import 'package:ecommerce_task_test/splash/screen/splash_screen.dart';
import 'package:get/get.dart';
import '../auth/binding/auth_binding.dart';
import '../auth/screen/auth_screen.dart';
import '../page_detail/binding/product_detail_binding.dart';
import '../page_detail/screen/product_detail_page.dart';
import '../splash/binding/splash_binding.dart';

class AppRouter {
  static getUnknownRoute() {
    return GetPage(
      name: RouteName.noPageFound,
      page: () => const UnknownRouteScreen(),
      transition: Transition.zoom,
    );
  }

  static getInitialRoute() {
    return RouteName.splashScreen;
  }

  static getPages() {
    return [
      GetPage(
        name: RouteName.authScreen,
        page: () => AuthScreen(),
        binding: AuthBinding(),
      ),
      GetPage(
        name: RouteName.productDetailPage,
        page: () => ProductDetailScreen(),
        binding: ProductDetailBinding(),
      ),
      GetPage(
        name: RouteName.splashScreen,
        page: () => SplashScreen(),
        binding: SplashBinding(),
      ),
    ];
  }
}
