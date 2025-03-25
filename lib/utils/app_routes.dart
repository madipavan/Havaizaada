import '../presentation/homepage/page/home_page.dart';
import '../presentation/spalshPage/page/splash_page.dart';

class AppRouts {
  static final routes = {
    "/": (context) => const SplashPage(),
    '/Homepage': (context) => const HomePage()
  };
}
