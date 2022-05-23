import 'package:techtest/src/presentasion/screens/category/category_screen.dart';
import 'package:techtest/src/presentasion/screens/home/home_screen.dart';
import 'package:techtest/src/presentasion/screens/login/login_screen.dart';
import 'package:techtest/src/presentasion/screens/onboarding/onboarding_screen.dart';
import 'package:techtest/src/presentasion/screens/root.dart';

class Routes {
  static final route = {
    Root.routeName: (context) => const Root(),
    HomeScreen.routeName: (context) => const HomeScreen(),
    OnboardingScreen.routeName: (context) => const OnboardingScreen(),
    LoginScreen.routeName: (context) => const LoginScreen(),
    CategoryScreen.routeName: (context) => const CategoryScreen(),
  };
}
