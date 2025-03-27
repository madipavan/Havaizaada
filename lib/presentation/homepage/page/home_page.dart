import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzen/common/helper/snackbar_helper.dart';
import 'package:newzen/core/configs/theme/app_color.dart';
import 'package:newzen/presentation/homepage/bloc/product_listing/product_listing_bloc.dart';
import 'package:newzen/presentation/homepage/bloc/product_listing/product_listing_event.dart';
import 'package:newzen/presentation/homepage/bloc/product_listing/product_listing_state.dart';
import 'package:newzen/presentation/shopping_cart/bloc/product_to_cart/cart_bloc.dart';
import 'package:newzen/presentation/shopping_cart/bloc/product_to_cart/cart_event.dart';
import 'package:newzen/presentation/shopping_cart/bloc/product_to_cart/cart_state.dart';

import '../../../common/widget/product_card.dart';

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
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (state is ProductListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: GridView.builder(
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
                      context
                          .read<ProductListingBloc>()
                          .add(FetchProductList());
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ));
                    } else {
                      return ProductCard(
                        imageUrl: state.productList[index].imageUrl,
                        title: state.productList[index].title,
                        brand: state.productList[index].brand,
                        oldPrice: state.productList[index].oldPrice,
                        newPrice: state.productList[index].newPrice,
                        discount: state.productList[index].discount,
                        onAdding: () {
                          final cartProducts =
                              context.read<CartBloc>().state.cartProducts;
                          if (!cartProducts
                              .contains(state.productList[index])) {
                            context.read<CartBloc>().add(AddToCart(
                                product: state.productList[
                                    index])); //adding prodct to cart
                            CustomSnackbar.show(context,
                                message: "Product Added"); //snackbar
                          } else {
                            CustomSnackbar.show(context,
                                message: "Product Already Added"); //snackbar
                          }
                        },
                      );
                    }
                  }),
            );
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
    backgroundColor: AppColors.lightbackground,
    title: Text('Catalogue'),
    centerTitle: true,
    actions: [
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) => IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/CartPage');
            },
            icon: Badge(
              backgroundColor: AppColors.primary,
              label: Text(state.cartProducts.length.toString()),
              child: Icon(
                Icons.shopping_cart_outlined,
              ),
            )),
      )
    ],
  );
}
