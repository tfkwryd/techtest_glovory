import 'package:flutter/material.dart';
import 'package:techtest/src/presentasion/screens/home/home_screen.dart';

class Root extends StatelessWidget {
  static const routeName = '/';
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
