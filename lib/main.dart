import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:techtest/src/injector.dart';
import 'package:techtest/src/config/routers/routers.dart';

void main() async {
  await Injector.initializeDependencies();
  runApp(const MyApp());
  await Injector.dependencies();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'techtest',
        routes: Routes.route,
        initialRoute: '/',
      ),
    );
  }
}
