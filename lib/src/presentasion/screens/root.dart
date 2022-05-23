import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtest/src/presentasion/providers/app_provider.dart';
import 'package:techtest/src/presentasion/screens/home/home_screen.dart';
import 'package:techtest/src/presentasion/screens/loading_screen.dart';
import 'package:techtest/src/presentasion/screens/onboarding/onboarding_screen.dart';

class Root extends StatelessWidget {
  static const routeName = '/';
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Provider.of<AppProvider>(context, listen: true).isLoading) {
      return const LoadingScreen();
    }
    if (Provider.of<AppProvider>(context, listen: true).isFirstOpenApp) {
      return const OnboardingScreen();
    } else {
      return const HomeScreen();
    }
  }
}
