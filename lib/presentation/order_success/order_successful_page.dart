import 'package:flutter/material.dart';

class OrderSuccessfulPage extends StatefulWidget {
  const OrderSuccessfulPage({super.key});

  @override
  State<OrderSuccessfulPage> createState() => _OrderSuccessfulPageState();
}

class _OrderSuccessfulPageState extends State<OrderSuccessfulPage> {
  @override
  void initState() {
    super.initState();
    redirect(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
            'https://i.pinimg.com/originals/57/b5/48/57b54818e2011d482548fb54201ce6c1.gif'),
      ),
    );
  }

  //to redirect
  Future<void> redirect(BuildContext contxt) async {
    await Future.delayed(const Duration(seconds: 2));

    contxt.mounted
        ? Navigator.pushNamedAndRemoveUntil(
            contxt,
            "/Homepage",
            (route) => false,
          )
        : null;
  }
}
