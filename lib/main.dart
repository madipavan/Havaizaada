import 'package:flutter/material.dart';
import 'package:newzen/core/configs/theme/app_theme.dart';
import 'package:newzen/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lighttheme,
      routes: AppRouts.routes,
      initialRoute: '/',
    );
  }
}
