import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzen/core/configs/theme/app_theme.dart';
import 'package:newzen/presentation/homepage/bloc/product_listing/product_listing_event.dart';
import 'package:newzen/presentation/homepage/bloc/product_to_cart/cart_bloc.dart';
import 'package:newzen/service/products_service/products_api_service.dart';
import 'package:newzen/utils/app_routes.dart';

import 'presentation/homepage/bloc/product_listing/product_listing_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductListingBloc(ProductsApiService())..add(FetchProductList()),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lighttheme,
        routes: AppRouts.routes,
        initialRoute: '/',
      ),
    );
  }
}
