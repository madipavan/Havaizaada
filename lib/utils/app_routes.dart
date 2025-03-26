import '../presentation/homepage/page/home_page.dart';
import '../presentation/order_success/order_successful_page.dart';
import '../presentation/shopping_cart/pages/cart_page.dart';
import '../presentation/spalshPage/page/splash_page.dart';

class AppRouts {
  static final routes = {
    "/": (context) => const SplashPage(),
    '/Homepage': (context) => HomePage(),
    '/CartPage': (context) => CartPage(),
    '/OrderSuccessfulPage': (context) => OrderSuccessfulPage(),
  };
}
