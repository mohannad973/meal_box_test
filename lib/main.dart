import 'package:flutter/material.dart';
import 'package:meal_box/providers/menu_provider.dart';
import 'package:meal_box/ui/splash.dart';
import 'package:meal_box/util/const.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Constants.lightTheme,
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      home: SplashScreen(),
    );
  }
}
