import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzen/presentation/homepage/bloc/product_listing/product_listing_bloc.dart';
import 'package:newzen/presentation/homepage/bloc/product_listing/product_listing_event.dart';
import 'package:newzen/presentation/homepage/bloc/product_listing/product_listing_state.dart';
import 'package:newzen/presentation/homepage/bloc/product_to_cart/cart_bloc.dart';
import 'package:newzen/presentation/homepage/bloc/product_to_cart/cart_event.dart';
import 'package:newzen/presentation/homepage/bloc/product_to_cart/cart_state.dart';

import '../widget/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(context),
        body: BlocBuilder<ProductListingBloc, ProductListingState>(
            builder: (context, state) {
          if (state.productList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductListLoaded) {
            return GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 products per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.68,
                ),
                itemCount: state.productList.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.productList.length) {
                    context.read<ProductListingBloc>().add(FetchProductList());
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ProductCard(
                      imageUrl: state.productList[index].imageUrl,
                      title: state.productList[index].title,
                      brand: state.productList[index].brand,
                      oldPrice: state.productList[index].oldPrice,
                      newPrice: state.productList[index].newPrice,
                      discount: state.productList[index].discount,
                      onAdding: () {
                        if (!context
                            .read<CartBloc>()
                            .cartProducts
                            .contains(state.productList[index])) {
                          context.read<CartBloc>().add(
                              AddToCart(product: state.productList[index]));
                          print(" added");
                        } else {
                          print("already added");
                        }
                      },
                    );
                  }
                });
          } else {
            return Center(
              child: Text('error'),
            );
          }
        }),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    title: Text('Catalogue'),
    centerTitle: true,
    actions: [
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) => IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/CartPage');
            },
            icon: Badge(
              label: Text(state.cartProducts.length.toString()),
              child: Icon(
                Icons.shopping_cart_outlined,
              ),
            )),
      )
    ],
  );
}
