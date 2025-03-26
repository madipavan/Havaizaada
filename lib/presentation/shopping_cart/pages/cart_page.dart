import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzen/presentation/homepage/bloc/product_to_cart/cart_state.dart';
import 'package:newzen/presentation/homepage/widget/product_card.dart';

import '../../homepage/bloc/product_to_cart/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return ProductCard(
                imageUrl: state.cartProducts[index].imageUrl,
                title: state.cartProducts[index].title,
                brand: "brand",
                oldPrice: 54.0,
                newPrice: 20.0,
                discount: 20.00,
                isCartView: true,
              );
            },
            separatorBuilder: (context, index) => SizedBox(),
            itemCount: state.cartProducts.length);
      }),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios)),
    title: Text('Cart'),
    centerTitle: true,
  );
}
