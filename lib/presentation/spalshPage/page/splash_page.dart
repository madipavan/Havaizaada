import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.menu_book),
      ),
    );
  }

  //to redirect
  Future<void> redirect(BuildContext contxt) async {
    await Future.delayed(const Duration(seconds: 2));

    contxt.mounted ? Navigator.pushReplacementNamed(contxt, "/Homepage") : null;
  }
}
