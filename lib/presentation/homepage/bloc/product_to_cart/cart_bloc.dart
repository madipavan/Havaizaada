import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzen/models/product_model.dart';
import 'package:newzen/presentation/homepage/bloc/product_to_cart/cart_event.dart';
import 'package:newzen/presentation/homepage/bloc/product_to_cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<ProductModel> cartProducts = [];
  CartBloc() : super(CartState()) {
    on<AddToCart>(_addProductTocart);
  }

  void _addProductTocart(AddToCart event, Emitter<CartState> emit) {
    cartProducts.add(event.product);

    emit(CartUpdated(cartProducts: List.from(cartProducts)));
  }
}
