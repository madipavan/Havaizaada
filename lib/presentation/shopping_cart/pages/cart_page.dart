import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzen/common/widget/product_card.dart';
import 'package:newzen/presentation/shopping_cart/bloc/product_to_cart/cart_event.dart';
import 'package:newzen/presentation/shopping_cart/bloc/product_to_cart/cart_state.dart';

import '../../../common/helper/snackbar_helper.dart';
import '../bloc/product_to_cart/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      bottomNavigationBar: _bottomBar(context),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ProductCard(
                  imageUrl: state.cartProducts[index].imageUrl,
                  title: state.cartProducts[index].title,
                  brand: state.cartProducts[index].brand,
                  oldPrice: state.cartProducts[index].oldPrice,
                  newPrice: state.cartProducts[index].newPrice,
                  discount: state.cartProducts[index].discount,
                  isCartView: true,
                  quantity: state.cartProducts[index].quantity,
                  increaseQuantity: () {
                    context.read<CartBloc>().add(IncreaseProductQuantity(
                        id: state.cartProducts[index].id));
                  },
                  decreaseQuantity: () {
                    context.read<CartBloc>().add(DecreaseProductQuantity(
                        id: state.cartProducts[index].id));
                  },
                  removeProduct: () {
                    context.read<CartBloc>().add(
                        RemoveFromCart(product: state.cartProducts[index]));
                    CustomSnackbar.show(context,
                        message: "Product Removed"); //snackbar
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: state.cartProducts.length),
        );
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

Widget _bottomBar(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(25),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Amount Price"),
            SizedBox(
              height: 15,
            ),
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              return Text(
                '₹${state.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
          ],
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              Navigator.pushNamed(context, '/OrderSuccessfulPage');
            },
            child: Row(
              children: [
                Text(
                  'Check Out',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Text(state.totalQuantity.toString()),
                  );
                })
              ],
            ))
      ],
    ),
  );
}
